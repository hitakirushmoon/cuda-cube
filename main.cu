#include <iostream>
#include <chrono>
#include <fstream>
#include <algorithm>

#define stack_size_limit 9000000
using namespace std;

#include "consts.cuh"

template<typename T>
void read_file(const string &name, T *buffer) {
    std::ifstream is;
    is.open(name, ios::in | ios::binary | ios::ate);
    size_t filesize = is.tellg();
    cout << filesize / sizeof(T) << endl << name << endl;
    is.seekg(0, std::ios::beg);
    is.read((char *) buffer, filesize / 2);
    is.read((char *) buffer + filesize / 2, filesize - filesize / 2);
    is.close();
    is.clear();
    cout << "done" << endl;
}

class full_cube {
    constexpr static const uint8_t C[6][4] = {{0, 1, 2, 3},
                                              {4, 5, 6, 7},
                                              {0, 3, 4, 7},
                                              {6, 5, 2, 1},
                                              {4, 3, 2, 5},
                                              {6, 1, 0, 7}};;
    constexpr static const uint8_t CORNER_ROTATE[18][4] = {{3, 0, 1, 2},
                                                           {2, 3, 0, 1},
                                                           {1, 2, 3, 0},
                                                           {7, 4, 5, 6},
                                                           {6, 7, 4, 5},
                                                           {5, 6, 7, 4},
                                                           {7, 0, 3, 4},
                                                           {4, 7, 0, 3},
                                                           {3, 4, 7, 0},
                                                           {1, 6, 5, 2},
                                                           {2, 1, 6, 5},
                                                           {5, 2, 1, 6},
                                                           {5, 4, 3, 2},
                                                           {2, 5, 4, 3},
                                                           {3, 2, 5, 4},
                                                           {7, 6, 1, 0},
                                                           {0, 7, 6, 1},
                                                           {1, 0, 7, 6}};
    constexpr static const uint8_t CORNER_SYMS[48][8] = {{0, 1, 2, 3, 4, 5, 6, 7},
                                                         {3, 2, 1, 0, 7, 6, 5, 4},
                                                         {4, 5, 6, 7, 0, 1, 2, 3},
                                                         {7, 6, 5, 4, 3, 2, 1, 0},
                                                         {3, 0, 1, 2, 5, 6, 7, 4},
                                                         {0, 3, 2, 1, 6, 5, 4, 7},
                                                         {7, 4, 5, 6, 1, 2, 3, 0},
                                                         {4, 7, 6, 5, 2, 1, 0, 3},
                                                         {2, 3, 0, 1, 6, 7, 4, 5},
                                                         {1, 0, 3, 2, 5, 4, 7, 6},
                                                         {6, 7, 4, 5, 2, 3, 0, 1},
                                                         {5, 4, 7, 6, 1, 0, 3, 2},
                                                         {1, 2, 3, 0, 7, 4, 5, 6},
                                                         {2, 1, 0, 3, 4, 7, 6, 5},
                                                         {5, 6, 7, 4, 3, 0, 1, 2},
                                                         {6, 5, 4, 7, 0, 3, 2, 1},
                                                         {2, 5, 4, 3, 0, 7, 6, 1},
                                                         {1, 6, 7, 0, 3, 4, 5, 2},
                                                         {6, 1, 0, 7, 4, 3, 2, 5},
                                                         {5, 2, 3, 4, 7, 0, 1, 6},
                                                         {1, 6, 5, 2, 3, 4, 7, 0},
                                                         {2, 5, 6, 1, 0, 7, 4, 3},
                                                         {5, 2, 1, 6, 7, 0, 3, 4},
                                                         {6, 1, 2, 5, 4, 3, 0, 7},
                                                         {0, 7, 6, 1, 2, 5, 4, 3},
                                                         {3, 4, 5, 2, 1, 6, 7, 0},
                                                         {4, 3, 2, 5, 6, 1, 0, 7},
                                                         {7, 0, 1, 6, 5, 2, 3, 4},
                                                         {3, 4, 7, 0, 1, 6, 5, 2},
                                                         {0, 7, 4, 3, 2, 5, 6, 1},
                                                         {7, 0, 3, 4, 5, 2, 1, 6},
                                                         {4, 3, 0, 7, 6, 1, 2, 5},
                                                         {4, 7, 0, 3, 2, 1, 6, 5},
                                                         {7, 4, 3, 0, 1, 2, 5, 6},
                                                         {0, 3, 4, 7, 6, 5, 2, 1},
                                                         {3, 0, 7, 4, 5, 6, 1, 2},
                                                         {5, 4, 3, 2, 1, 0, 7, 6},
                                                         {6, 7, 0, 1, 2, 3, 4, 5},
                                                         {1, 0, 7, 6, 5, 4, 3, 2},
                                                         {2, 3, 4, 5, 6, 7, 0, 1},
                                                         {6, 5, 2, 1, 0, 3, 4, 7},
                                                         {5, 6, 1, 2, 3, 0, 7, 4},
                                                         {2, 1, 6, 5, 4, 7, 0, 3},
                                                         {1, 2, 5, 6, 7, 4, 3, 0},
                                                         {7, 6, 1, 0, 3, 2, 5, 4},
                                                         {4, 5, 2, 3, 0, 1, 6, 7},
                                                         {3, 2, 5, 4, 7, 6, 1, 0},
                                                         {0, 1, 6, 7, 4, 5, 2, 3}};
    constexpr static const uint8_t E[6][4] = {{0,  1,  2,  3},
                                              {11, 10, 9,  8},
                                              {0,  7,  8,  4},
                                              {2,  5,  10, 6},
                                              {3,  6,  11, 7},
                                              {1,  4,  9,  5}};
    constexpr static const uint8_t EDGE_ROTATE[18][4] = {{3,  0,  1,  2},
                                                         {2,  3,  0,  1},
                                                         {1,  2,  3,  0},
                                                         {8,  11, 10, 9},
                                                         {9,  8,  11, 10},
                                                         {10, 9,  8,  11},
                                                         {4,  0,  7,  8},
                                                         {8,  4,  0,  7},
                                                         {7,  8,  4,  0},
                                                         {6,  2,  5,  10},
                                                         {10, 6,  2,  5},
                                                         {5,  10, 6,  2},
                                                         {7,  3,  6,  11},
                                                         {11, 7,  3,  6},
                                                         {6,  11, 7,  3},
                                                         {5,  1,  4,  9},
                                                         {9,  5,  1,  4},
                                                         {4,  9,  5,  1}};
    constexpr static const uint8_t EDGE_SYMS[48][12] = {{0,  1,  2,  3,  4,  5,  6,  7,  8,  9,  10, 11},
                                                        {0,  3,  2,  1,  7,  6,  5,  4,  8,  11, 10, 9},
                                                        {8,  11, 10, 9,  7,  6,  5,  4,  0,  3,  2,  1},
                                                        {8,  9,  10, 11, 4,  5,  6,  7,  0,  1,  2,  3},
                                                        {3,  0,  1,  2,  7,  4,  5,  6,  11, 8,  9,  10},
                                                        {1,  0,  3,  2,  4,  7,  6,  5,  9,  8,  11, 10},
                                                        {9,  8,  11, 10, 4,  7,  6,  5,  1,  0,  3,  2},
                                                        {11, 8,  9,  10, 7,  4,  5,  6,  3,  0,  1,  2},
                                                        {2,  3,  0,  1,  6,  7,  4,  5,  10, 11, 8,  9},
                                                        {2,  1,  0,  3,  5,  4,  7,  6,  10, 9,  8,  11},
                                                        {10, 9,  8,  11, 5,  4,  7,  6,  2,  1,  0,  3},
                                                        {10, 11, 8,  9,  6,  7,  4,  5,  2,  3,  0,  1},
                                                        {1,  2,  3,  0,  5,  6,  7,  4,  9,  10, 11, 8},
                                                        {3,  2,  1,  0,  6,  5,  4,  7,  11, 10, 9,  8},
                                                        {11, 10, 9,  8,  6,  5,  4,  7,  3,  2,  1,  0},
                                                        {9,  10, 11, 8,  5,  6,  7,  4,  1,  2,  3,  0},
                                                        {3,  6,  11, 7,  2,  10, 8,  0,  1,  5,  9,  4},
                                                        {1,  5,  9,  4,  2,  10, 8,  0,  3,  6,  11, 7},
                                                        {9,  5,  1,  4,  10, 2,  0,  8,  11, 6,  3,  7},
                                                        {11, 6,  3,  7,  10, 2,  0,  8,  9,  5,  1,  4},
                                                        {2,  5,  10, 6,  1,  9,  11, 3,  0,  4,  8,  7},
                                                        {2,  6,  10, 5,  3,  11, 9,  1,  0,  7,  8,  4},
                                                        {10, 6,  2,  5,  11, 3,  1,  9,  8,  7,  0,  4},
                                                        {10, 5,  2,  6,  9,  1,  3,  11, 8,  4,  0,  7},
                                                        {1,  4,  9,  5,  0,  8,  10, 2,  3,  7,  11, 6},
                                                        {3,  7,  11, 6,  0,  8,  10, 2,  1,  4,  9,  5},
                                                        {11, 7,  3,  6,  8,  0,  2,  10, 9,  4,  1,  5},
                                                        {9,  4,  1,  5,  8,  0,  2,  10, 11, 7,  3,  6},
                                                        {0,  7,  8,  4,  3,  11, 9,  1,  2,  6,  10, 5},
                                                        {0,  4,  8,  7,  1,  9,  11, 3,  2,  5,  10, 6},
                                                        {8,  4,  0,  7,  9,  1,  3,  11, 10, 5,  2,  6},
                                                        {8,  7,  0,  4,  11, 3,  1,  9,  10, 6,  2,  5},
                                                        {7,  8,  4,  0,  11, 9,  1,  3,  6,  10, 5,  2},
                                                        {4,  8,  7,  0,  9,  11, 3,  1,  5,  10, 6,  2},
                                                        {4,  0,  7,  8,  1,  3,  11, 9,  5,  2,  6,  10},
                                                        {7,  0,  4,  8,  3,  1,  9,  11, 6,  2,  5,  10},
                                                        {6,  11, 7,  3,  10, 8,  0,  2,  5,  9,  4,  1},
                                                        {5,  9,  4,  1,  10, 8,  0,  2,  6,  11, 7,  3},
                                                        {5,  1,  4,  9,  2,  0,  8,  10, 6,  3,  7,  11},
                                                        {6,  3,  7,  11, 2,  0,  8,  10, 5,  1,  4,  9},
                                                        {5,  10, 6,  2,  9,  11, 3,  1,  4,  8,  7,  0},
                                                        {6,  10, 5,  2,  11, 9,  1,  3,  7,  8,  4,  0},
                                                        {6,  2,  5,  10, 3,  1,  9,  11, 7,  0,  4,  8},
                                                        {5,  2,  6,  10, 1,  3,  11, 9,  4,  0,  7,  8},
                                                        {4,  9,  5,  1,  8,  10, 2,  0,  7,  11, 6,  3},
                                                        {7,  11, 6,  3,  8,  10, 2,  0,  4,  9,  5,  1},
                                                        {7,  3,  6,  11, 0,  2,  10, 8,  4,  1,  5,  9},
                                                        {4,  1,  5,  9,  0,  2,  10, 8,  7,  3,  6,  11}};

    uint8_t corner_perm[8] = {0, 1, 2, 3, 4, 5, 6, 7};
    uint8_t corner_or[8] = {};
    uint8_t edge_perm[12] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11};
    uint8_t edge_or[12] = {};
public:
    void print() {
        copy(begin(corner_or),
             end(corner_or),
             ostream_iterator<short>(cout, ", "));
        cout << endl;
        copy(begin(corner_perm),
             end(corner_perm),
             ostream_iterator<short>(cout, ", "));
        cout << endl;
        copy(begin(edge_or),
             end(edge_or),
             ostream_iterator<short>(cout, ", "));
        cout << endl;
        copy(begin(edge_perm),
             end(edge_perm),
             ostream_iterator<short>(cout, ", "));
        cout << endl;
        cout << endl;

    }

    full_cube &move(const uint32_t move) {
        if (move > 17) dual();
        uint32_t m = move / 3;
        uint8_t temp_perm[4];
        uint8_t temp_or[4];
        for (int i = 0; i < 4; i++) {
            temp_perm[i] = edge_perm[E[m][i]];
            temp_or[i] = edge_or[E[m][i]];
        }
        for (int i = 0; i < 4; i++) {
            edge_perm[EDGE_ROTATE[move][i]] = temp_perm[i];
            edge_or[EDGE_ROTATE[move][i]] = temp_or[i] ^ 1 ^ (move % 3 % 2);
        }

        for (int i = 0; i < 4; i++) {
            temp_perm[i] = corner_perm[C[m][i]];
            temp_or[i] = corner_or[C[m][i]];
        }
        for (int i = 0; i < 4; i++) {
            corner_perm[CORNER_ROTATE[move][i]] = temp_perm[i];
        }
        bool special_case = (move % 3 % 2 == 1 || m < 2);
        for (int i = 0; i < 4; i++) {
            corner_or[CORNER_ROTATE[move][i]] = special_case ? temp_or[i] : (temp_or[i] + (i % 2 + 1) * (3 - m / 2)) % 3;
        }
        return *this;
    }

    full_cube &move(const string &moves) {
        istringstream iss(moves);
        string item;
        while (getline(iss, item, ' ')) {
            uint8_t next_move = get_move_int(item);
            if (next_move == 18) {
                cout << "yo wtf is " << item << endl;
            }
            move(next_move);
        }
        return *this;
    }

    full_cube &dual() {
        uint8_t temp_corner_perm[8];
        uint8_t temp_corner_or[8];
        uint8_t temp_edge_perm[12];
        uint8_t temp_edge_or[12];

        for (uint8_t i = 0; i < 8; i++) {
            temp_corner_perm[corner_perm[i]] = i;
            temp_corner_or[corner_perm[i]] = ((corner_or[i] * 2) % 3);
        }
        for (uint8_t i = 0; i < 12; i++) {
            temp_edge_perm[edge_perm[i]] = i;
            temp_edge_or[edge_perm[i]] = edge_or[i];
        }
        copy(begin(temp_corner_perm), end(temp_corner_perm), begin(corner_perm));
        copy(begin(temp_corner_or), end(temp_corner_or), begin(corner_or));
        copy(begin(temp_edge_perm), end(temp_edge_perm), begin(edge_perm));
        copy(begin(temp_edge_or), end(temp_edge_or), begin(edge_or));

        return *this;
    }

    full_cube &sym(const uint8_t sym_dual) {
        int sym = sym_dual % 48;
        uint8_t temp_edge_perm[12];
        uint8_t temp_edge_or[12];
        for (uint8_t i = 0; i < 12; i++) {
            temp_edge_perm[edge_perm[EDGE_SYMS[sym][i]]] = i;
            temp_edge_or[i] = edge_or[EDGE_SYMS[sym][i]];
        }
        for (uint8_t i = 0; i < 12; i++) {
            edge_perm[temp_edge_perm[EDGE_SYMS[sym][i]]] = i;
        }
        copy(begin(temp_edge_or), end(temp_edge_or), begin(edge_or));

        uint8_t temp_corner_perm[8];
        uint8_t temp_corner_or[8];
        int c_index = sym >> 4;
        int lr_index = sym % 2;
        for (uint8_t i = 0; i < 8; i++) {
            temp_corner_perm[corner_perm[CORNER_SYMS[sym][i]]] = i;
            if (lr_index == 1) {
                corner_or[CORNER_SYMS[sym][i]] *= 2;
            }
            if (c_index != 0) {
                temp_corner_or[i] = ((2 - i % 2) * c_index + corner_or[CORNER_SYMS[sym][i]]) % 3;
            } else {
                temp_corner_or[i] = corner_or[CORNER_SYMS[sym][i]] % 3;
            }
        }
        for (uint8_t i = 0; i < 8; i++) {
            corner_perm[temp_corner_perm[CORNER_SYMS[sym][i]]] = i;
        }
        if (c_index == 0) {
            copy(begin(temp_corner_or), end(temp_corner_or), begin(corner_or));
        } else {
            for (uint8_t i = 0; i < 8; i++) {
                uint8_t new_i = temp_corner_perm[CORNER_SYMS[sym][i]];
                corner_or[new_i] = ((1 + i % 2) * c_index + temp_corner_or[new_i]) % 3;
            }
        }
        return sym_dual < 48 ? *this : dual();
    }

    uint32_t edge_perm_hash() {
        return factorial_hash(edge_perm, 12);
    }

    uint16_t edge_or_hash() {
        return normal_hash(edge_or, 2, 12);
    }

    uint32_t full_corner_hash() {
        return factorial_hash(corner_perm, 8) * 2187 + normal_hash(corner_or, 3, 8);
    }
};



__device__ uint32_t device_edge_perm_neighbours[10044410][18];

__device__ uint16_t device_edge_or_neighbours[2048][18];
__device__ uint16_t device_edge_or_symmetries[2048][48];
__device__ uint16_t device_edge_or_dual[10044410][4];

__device__ uint32_t device_full_corner_neighbours[1841970][18];
__device__ uint32_t device_full_corner_dual[1841970];
__device__ uint64_t *device_edge_perm_pattern_database;
__device__ uint64_t *device_full_corner_pattern_database;

__constant__ uint8_t device_rotated_moves[18][48];
__constant__ uint8_t device_rotated_syms[48][48];
__constant__ uint8_t device_dual_sym[48];
__constant__ uint8_t device_dual_move[18];

static auto host_edge_perm_pattern_database = new uint64_t[335544315];
static auto host_full_corner_pattern_database = new uint64_t[235772160];

static auto host_edge_perm_indexes = new uint32_t[5022205];
static auto host_edge_perm_neighbours = new uint32_t[10044410][18];

static auto host_edge_or_neighbours = new uint16_t[2048][18];
static auto host_edge_or_symmetries = new uint16_t[2048][48];
static auto host_edge_or_dual = new uint16_t[10044410][4];

static auto host_full_corner_indexes = new uint32_t[1841970];
static auto host_full_corner_neighbours = new uint32_t[1841970][18];
static auto host_full_corner_dual = new uint32_t[1841970];

class index_cube {
public:
    uint32_t edge_perm;
    uint32_t full_corner;
    uint16_t edge_or;
    uint8_t perm_sym, corner_sym;

    __host__ explicit index_cube(full_cube c) {
        edge_or = c.edge_or_hash();
        for (perm_sym = 0; perm_sym < 96; perm_sym++) {
            full_cube clone = c;
            uint32_t temp_hash = clone.sym(perm_sym).edge_perm_hash();
            edge_perm = lower_bound(host_edge_perm_indexes, host_edge_perm_indexes + 5022205, temp_hash) - host_edge_perm_indexes;
            if (host_edge_perm_indexes[edge_perm] == temp_hash) break;
        }
        edge_perm = edge_perm * 2 + perm_sym / 48;
        perm_sym %= 48;
        for (corner_sym = 0; corner_sym < 48; corner_sym++) {
            full_cube clone = c;
            uint32_t temp_hash = clone.sym(corner_sym).full_corner_hash();
            full_corner = lower_bound(host_full_corner_indexes, host_full_corner_indexes + 1841970, temp_hash) - host_full_corner_indexes;
            if (host_full_corner_indexes[full_corner] == temp_hash) break;
        }

    }

    index_cube() = default;

    ~index_cube() = default;

    friend ostream &operator<<(ostream &os, const index_cube &cube) {
        os << "edge_perm: " << cube.edge_perm << " edge_or: " << cube.edge_or << " full_corner: " << cube.full_corner << " perm_sym: "
           << (short) cube.perm_sym
           << " corner_sym: "
           << (short) cube.corner_sym;
        return os;
    }

    __device__ void device_move(uint8_t i) {
        edge_or = device_edge_or_neighbours[edge_or][i];
        int perm_move = device_rotated_moves[i][perm_sym];
        edge_perm = device_edge_perm_neighbours[edge_perm][perm_move];
        perm_sym = device_rotated_syms[perm_sym][edge_perm % 48];
        edge_perm /= 48;
        int corner_move = device_rotated_moves[i][corner_sym];
        full_corner = device_full_corner_neighbours[full_corner][corner_move];
        corner_sym = device_rotated_syms[corner_sym][full_corner % 48];
        full_corner /= 48;
    }

    __host__ void host_move(uint8_t i) {
        edge_or = host_edge_or_neighbours[edge_or][i];
        int perm_move = host_rotated_moves[i][perm_sym];
        edge_perm = host_edge_perm_neighbours[edge_perm][perm_move];
        perm_sym = host_rotated_syms[perm_sym][edge_perm % 48];
        edge_perm /= 48;
        int corner_move = host_rotated_moves[i][corner_sym];
        full_corner = host_full_corner_neighbours[full_corner][corner_move];
        corner_sym = host_rotated_syms[corner_sym][full_corner % 48];
        full_corner /= 48;

    }

    __host__ index_cube move(const string &moves) const {
        istringstream iss(moves);
        string item;
        index_cube current = *this;
        while (getline(iss, item, ' ')) {
            current.host_move(get_move_int(item));
        }
        return current;
    }
};

class search_state {
public:

    friend ostream &operator<<(ostream &os, const search_state &state) {
        os << "i: " << state.i << " h_corner: " << (short) state.h_corner << " h_edge: " << (short) state.h_edge;
        return os;
    }

    index_cube i;
    uint8_t h_corner, h_edge;

    search_state() = default;

    __host__ explicit search_state(const full_cube cube) : i(cube) {
        h_edge = 0;
        index_cube current = i;
        int current_mod = read_from_edge_array(current);
        while (current.edge_perm + current.edge_or != 0) {
            for (int move = 0; move < 18; move++) {
                index_cube next = current;
                next.host_move(move);
                if ((read_from_edge_array(next) + 1) % 3 == current_mod) {
                    current_mod = (current_mod + 2) % 3;
                    current = next;
                    h_edge++;
                    break;
                }
            }
        }
        h_corner = read_from_corner_array(i);
    }

    __device__ __host__ static uint8_t max(uint8_t a, uint8_t b) {
        return a > b ? a : b;
    }

    __host__ bool host_move(int move) {
        i.host_move(move);
        if (i.edge_perm / 2 + i.full_corner + i.edge_or == 0)
            return true;
        uint16_t corner_corrected_edge_or = host_edge_or_symmetries[i.edge_or][i.corner_sym];
        uint16_t edge_perm_corrected_edge_or = host_edge_or_symmetries[i.edge_or][i.perm_sym];
        uint16_t *dual = host_edge_or_dual[i.edge_perm];
        uint16_t edge_perm_corrected_dual_edge_or = get_inverse_bits_from_lehmer_code(edge_perm_corrected_edge_or, dual[0], dual[1], dual[2],
                                                                                      dual[3]);
        h_corner = max(max(h_corner, 1) - 1, max(host_read_from_corner_array(i.full_corner, corner_corrected_edge_or),
                                                 host_read_from_corner_array(host_full_corner_dual[i.full_corner] / 48,
                                                                             host_edge_or_symmetries[edge_perm_corrected_dual_edge_or][host_rotated_syms[host_rotated_syms[host_dual_sym[i.perm_sym]][i.corner_sym]][
                                                                                     host_full_corner_dual[i.full_corner] % 48]])));
        h_edge += (host_read_from_edge_array(i.edge_perm, i.edge_perm % 2 == 0 ? edge_perm_corrected_edge_or : edge_perm_corrected_dual_edge_or) +
                   h_edge * 2 + 1) % 3 - 1;
        return false;
    }


    __device__ bool device_move(int move) {
        i.device_move(move);
        if (i.edge_perm / 2 + i.full_corner + i.edge_or == 0)
            return true;
        uint16_t edge_perm_corrected_edge_or = device_edge_or_symmetries[i.edge_or][i.perm_sym];
        uint16_t *dual = device_edge_or_dual[i.edge_perm];
        uint16_t edge_perm_corrected_dual_edge_or = get_inverse_bits_from_lehmer_code(edge_perm_corrected_edge_or, dual[0], dual[1], dual[2],
                                                                                      dual[3]);
        h_corner = max(max(h_corner, 1) - 1, max(device_read_from_corner_array(i.full_corner, device_edge_or_symmetries[i.edge_or][i.corner_sym]),
                                                 device_read_from_corner_array(device_full_corner_dual[i.full_corner] / 48,
                                                                               device_edge_or_symmetries[edge_perm_corrected_dual_edge_or][device_rotated_syms[device_rotated_syms[device_dual_sym[i.perm_sym]][i.corner_sym]][
                                                                                       device_full_corner_dual[i.full_corner] % 48]])));
        h_edge += (device_read_from_edge_array(i.edge_perm, i.edge_perm % 2 == 0 ? edge_perm_corrected_edge_or : edge_perm_corrected_dual_edge_or) +
                   h_edge * 2 + 1) % 3 - 1;
        return false;
    }


    __host__ __device__  uint8_t h() const {
        return max(h_edge, h_corner);
    }

    static uint8_t read_from_edge_array(const index_cube &c) {
        uint16_t edge_or = c.edge_or;
        edge_or = host_edge_or_symmetries[edge_or][c.perm_sym];
        if (c.edge_perm % 2 == 1) {
            uint16_t *dual = host_edge_or_dual[c.edge_perm];
            edge_or = get_inverse_bits_from_lehmer_code(edge_or, dual[0], dual[1], dual[2], dual[3]);
        }
        return host_read_from_edge_array(c.edge_perm, edge_or);
    }

    __host__ static uint8_t host_read_from_edge_array(const uint32_t edge_perm, const uint16_t edge_or) {
        return (host_edge_perm_pattern_database[edge_perm / 2 * 64 + edge_or / 32] >> (edge_or % 32 * 2)) & 0b11;
    }

    __device__ static uint8_t device_read_from_edge_array(const uint32_t edge_perm, const uint16_t edge_or) {
        return (device_edge_perm_pattern_database[edge_perm / 2 * 64 + edge_or / 32] >> (edge_or % 32 * 2)) & 0b11;
    }

    __host__ static uint8_t read_from_corner_array(const index_cube &c) {
        uint16_t temp_edge_or = host_edge_or_symmetries[c.edge_or][c.corner_sym];
        uint16_t *dual = host_edge_or_dual[c.edge_perm];
        uint16_t dual_edge_or = c.edge_or;
        dual_edge_or = host_edge_or_symmetries[dual_edge_or][c.perm_sym];
        dual_edge_or = get_inverse_bits_from_lehmer_code(dual_edge_or, dual[0], dual[1], dual[2], dual[3]);
        dual_edge_or = host_edge_or_symmetries[dual_edge_or][host_dual_sym[c.perm_sym]];
        dual_edge_or = host_edge_or_symmetries[dual_edge_or][c.corner_sym];
        dual_edge_or = host_edge_or_symmetries[dual_edge_or][host_full_corner_dual[c.full_corner] % 48];
        return max(host_read_from_corner_array(c.full_corner, temp_edge_or),
                   host_read_from_corner_array(host_full_corner_dual[c.full_corner] / 48, dual_edge_or));
    }

    __host__ static uint8_t host_read_from_corner_array(const uint32_t full_corner, const uint16_t edge_or) {
        return (host_full_corner_pattern_database[full_corner * 128 + edge_or / 16] >> (edge_or % 16 * 4)) & 0b1111;
    }

    __device__ static uint8_t device_read_from_corner_array(const uint32_t full_corner, const uint16_t edge_or) {
        return (device_full_corner_pattern_database[full_corner * 128 + edge_or / 16] >> (edge_or % 16 * 4)) & 0b1111;
    }
};

class mem_transfer {
public:
    uint8_t head;
    uint8_t prev_move, prev_move_2;
    uint8_t h;
    index_cube i;
};

class ida_stack {
public:
    int8_t head;
    int8_t moves[20];
    search_state state;

    __host__ __device__ ida_stack() : state{}, head{0}, moves{} {
        for (int8_t &move: moves) {
            move = -1;
        }
    }
    __host__ __device__ int8_t &current_move() {
        return moves[head];
    }

    __host__ __device__ bool check_unnecessary_move() {
        if (head > 0) {
            if (moves[head] / 6 == moves[head - 1] / 6) {
                return (moves[head] / 3 <= moves[head - 1] / 3) || (head > 1 && moves[head] / 6 == moves[head - 2] / 6);
            }
        }
        return false;
    }
};

__device__ mem_transfer device_stacks[stack_size_limit];
__device__ int8_t moves[20];
static auto host_stacks = vector<mem_transfer>();
__device__ volatile int32_t device_result;
static int32_t host_result;
static int8_t host_moves[20]{};

static ida_stack result;

#define gpuErrchk(ans) { gpuAssert((ans), __FILE__, __LINE__); }

inline void gpuAssert(cudaError_t code, const char *file, int line, bool abort = true) {
    if (code != cudaSuccess) {
        fprintf(stderr, "GPUassert: %s %s %d\n", cudaGetErrorString(code), file, line);
        if (abort) exit(code);
    }
}

void read_files() {


    cudaMemcpyToSymbol(device_rotated_moves, host_rotated_moves, 18 * 48 * sizeof(uint8_t));
    cudaMemcpyToSymbol(device_rotated_syms, host_rotated_syms, 48 * 48 * sizeof(uint8_t));
    cudaMemcpyToSymbol(device_dual_sym, host_dual_sym, 48 * sizeof(uint8_t));
    cudaMemcpyToSymbol(device_dual_move, host_dual_move, 18 * sizeof(uint8_t));

    uint64_t *device_edge_perm_pattern_database_address;
    read_file("../edge_perm_edge_or_pattern_database", host_edge_perm_pattern_database);
    gpuErrchk(cudaMalloc((void **) &device_edge_perm_pattern_database_address, 335544315 * sizeof(uint64_t)))
    cudaMemcpy(device_edge_perm_pattern_database_address, host_edge_perm_pattern_database, 335544315 * sizeof(uint64_t), cudaMemcpyHostToDevice);
    cudaMemcpyToSymbol(device_edge_perm_pattern_database, &device_edge_perm_pattern_database_address, sizeof(uint64_t *));

    uint64_t *device_full_corner_pattern_database_address;
    read_file("../corner_edge_or_pattern_database", host_full_corner_pattern_database);
    gpuErrchk(cudaMalloc((void **) &device_full_corner_pattern_database_address, 235772160 * sizeof(uint64_t)))
    cudaMemcpy(device_full_corner_pattern_database_address, host_full_corner_pattern_database, 235772160 * sizeof(uint64_t), cudaMemcpyHostToDevice);
    cudaMemcpyToSymbol(device_full_corner_pattern_database, &device_full_corner_pattern_database_address, sizeof(uint64_t *));

    read_file("../edge_perm_indexes", host_edge_perm_indexes);

    read_file("../edge_perm_neighbours", (uint32_t *) host_edge_perm_neighbours);
    cudaMemcpyToSymbol(device_edge_perm_neighbours, (uint32_t *) host_edge_perm_neighbours, 10044410 * 18 * sizeof(uint32_t));

    read_file("../edge_or_neighbours", (uint16_t *) host_edge_or_neighbours);
    cudaMemcpyToSymbol(device_edge_or_neighbours, (uint16_t *) host_edge_or_neighbours, 2048 * 18 * sizeof(uint16_t));

    read_file("../edge_or_symmetries", (uint16_t *) host_edge_or_symmetries);
    cudaMemcpyToSymbol(device_edge_or_symmetries, (uint16_t *) host_edge_or_symmetries, 2048 * 48 * sizeof(uint16_t));

    read_file("../edge_or_dual", (uint16_t *) host_edge_or_dual);
    cudaMemcpyToSymbol(device_edge_or_dual, (uint16_t *) host_edge_or_dual, 10044410 * 4 * sizeof(uint16_t));

    read_file("../corner_indexes", host_full_corner_indexes);

    read_file("../corner_neighbours", (uint32_t *) host_full_corner_neighbours);
    cudaMemcpyToSymbol(device_full_corner_neighbours, (uint32_t *) host_full_corner_neighbours, 1841970 * 18 * sizeof(uint32_t));

    read_file("../corner_dual", host_full_corner_dual);
    cudaMemcpyToSymbol(device_full_corner_dual, host_full_corner_dual, 1841970 * sizeof(uint32_t));
    cout << "import finished" << endl;
    gpuErrchk(cudaMalloc((void **) &device_result, sizeof(uint32_t)))

}

__host__ static int generate_stack(const search_state &init, const uint8_t bound, bool add_to_vector, int target_count = -1) {
    ida_stack ss{};
    ss.state = init;
//    host_stacks.clear();
    int count = 0;
    while (true) {
        if (++ss.current_move() == 18) {
            ss.current_move() = -1;
            ss.head--;
            if (ss.head < 0) {
                return count;
            }
            ss.state.host_move(host_dual_move[ss.current_move()]);
            continue;
        }
        if (ss.check_unnecessary_move()) continue;

        search_state current = ss.state;

        if (current.host_move(ss.current_move())) {
            cout << count << endl;
            for (const auto &item: ss.moves) {
                if (item == -1) break;
                cout << s[item] << ' ';
            }
            cout << endl;
            return -1;
        }
        if (++ss.head + current.h() > bound) {
            if (count++ == target_count) {
                result = ss;
                return -1;
            }
            if (add_to_vector) {
                mem_transfer mem{};
                mem.head = ss.head;
                mem.h = current.h_corner * 16 + current.h_edge;
                mem.prev_move_2 = ss.moves[ss.head - 2];
                mem.prev_move = ss.moves[ss.head - 1];
                mem.i = current.i;
                host_stacks.push_back(mem);
            }
            ss.head--;
            continue;
        }
        ss.state = current;
    }
}

__global__ void iterative_solve(const int limit, const int bound) {
    int tid = threadIdx.x + blockIdx.x * blockDim.x;
    extern __shared__ ida_stack shared_stacks[];
    if (tid < limit) {
        ida_stack &ss = shared_stacks[threadIdx.x];
        ss = ida_stack();
        ss.head = device_stacks[tid].head;
        ss.moves[ss.head - 1] = device_stacks[tid].prev_move;
        ss.moves[ss.head - 2] = device_stacks[tid].prev_move_2;
        ss.state.h_corner = device_stacks[tid].h / 16;
        ss.state.h_edge = device_stacks[tid].h % 16;
        ss.state.i = device_stacks[tid].i;
        const int original_layer = ss.head;
        while (ss.head >= original_layer && device_result == -1) {
            if (++ss.current_move() == 18) {
                ss.current_move() = -1;
                ss.head--;
                ss.state.device_move(device_dual_move[ss.current_move()]);
                continue;
            }
            if (ss.check_unnecessary_move()) continue;
            search_state current = ss.state;
            if (current.device_move(ss.current_move())) {
                if (device_result != -1) {
                    return;
                }
                device_result = tid;
                for (int i = original_layer; i < 20; i++) {
                    moves[i] = ss.moves[i];
                }
                return;
            }
            if (++ss.head + current.h() > bound) {
                ss.head--;
                continue;
            }
            ss.state = current;
        }
    }
}

struct unaryfn : std::unary_function<int, int> {
    __device__ __host__ int operator()(int i) const { return sizeof(ida_stack) * i; }
};

void solve_cube(full_cube &f) {
    search_state state(f);
    if (state.i.edge_perm / 2 + state.i.full_corner + state.i.edge_or == 0) {
        return;
    }
    cout << state << endl;
    int bound = state.h();
    int size;
    do {
        cout << bound << endl;
        auto t1 = chrono::high_resolution_clock::now();
        size = generate_stack(state, bound, false);
        auto t2 = chrono::high_resolution_clock::now();
        chrono::duration<double, milli> ms_double = t2 - t1;
        cout << "time: " << ms_double.count() << " " << size << endl;
        if (size == -1) {
            return;
        }
        bound++;
    } while (size * 14 < stack_size_limit);
    cout << "cuda time! w/ ";
    int true_bound = bound - 1;
    size = generate_stack(state, true_bound, true);
    cout << size << " states" << endl;
    host_result = -1;
    int blockSize;   // The launch configurator returned block size
    int minGridSize; // The minimum grid size needed to achieve the
    // maximum occupancy for a full device launch
    int gridSize;    // The actual grid size needed, based on input size
    cudaOccupancyMaxPotentialBlockSizeVariableSMem(&minGridSize, &blockSize, iterative_solve, unaryfn());
    // Round up according to array size
    gridSize = (size + blockSize - 1) / blockSize;
    cout << gridSize << " " << blockSize << endl;
    cout << "starting nodes: " << size << endl;
    gpuErrchk(cudaMemcpyToSymbol(device_stacks, &host_stacks[0], size * sizeof(mem_transfer)))
    gpuErrchk(cudaMemcpyToSymbol(device_result, &host_result, sizeof(int)))
    gpuErrchk(cudaDeviceSynchronize())
    while (true) {
        std::cout << bound << std::endl;
        auto t1 = chrono::high_resolution_clock::now();
        iterative_solve<<<gridSize, blockSize, blockSize * sizeof(ida_stack)>>>(size, bound);
        gpuErrchk(cudaGetLastError())
        gpuErrchk(cudaDeviceSynchronize())
        cudaMemcpyFromSymbol(&host_result, device_result, sizeof(int));
        cudaMemcpyFromSymbol(&host_moves, moves, 20 * sizeof(int8_t));
        gpuErrchk(cudaPeekAtLastError())
        gpuErrchk(cudaDeviceSynchronize())
        auto t2 = chrono::high_resolution_clock::now();
        if (host_result != -1) {
            generate_stack(state, true_bound, false, host_result);
            for (int i = 0; i < 20 && result.moves[i] != -1; i++) {
                cout << s[result.moves[i]] << " ";
            }
            for (int i = result.head; i < 20 && host_moves[i] != -1; i++) {
                cout << s[host_moves[i]] << " ";
            }
            cout << endl;
            chrono::duration<double, milli> ms_double = t2 - t1;
            cout << "time: " << ms_double.count() << endl;
            break;
        }
        chrono::duration<double, milli> ms_double = t2 - t1;
        cout << "time: " << ms_double.count() << endl;
        bound++;
    }

}


int main() {
    read_files();
//    int maxbytes = 98304; // 96 KB
//    cudaFuncSetAttribute(iterative_solve, cudaFuncAttributeMaxDynamicSharedMemorySize, maxbytes);
    string shuffle;
    while (true) {
        getline(cin, shuffle);
        if (shuffle == "done") break;
        full_cube c;
        c.move(shuffle).print();
        auto t1 = chrono::high_resolution_clock::now();
        solve_cube(c);
        auto t2 = chrono::high_resolution_clock::now();
        chrono::duration<double, milli> ms_double = t2 - t1;
        cout << "time: " << ms_double.count() << endl;
        host_stacks.clear();
    }
    return 0;
}