//
// Created by PC on 10/9/2021.
//
#include <vector>
#include "consts.cuh"

uint32_t factorial_hash(const uint8_t indexes[], const uint32_t length) {
    uint32_t hash = 0;
    for (uint32_t i = 0; i < length - 1; i++) {
        for (uint32_t j = i + 1; j < length; j++) {
            if (indexes[i] > indexes[j]) {
                hash++;
            }
        }
        hash *= length - i - 1;
    }
    return hash;
}

uint16_t normal_hash(const uint8_t indexes[], const uint32_t base, const uint32_t length) {
    uint32_t hash = 0;
    for (uint32_t i = 0; i < length - 1; i++) {
        hash *= base;
        hash += indexes[i];
    }
    return hash;
}

uint32_t get_move_int(const std::string &name) {
    for (uint32_t i = 0; i < 18; i++) {
        if (s[i] == name) {
            return i;
        }
    }
    return 18;
}

__device__ __host__ uint16_t get_inverse_bits_from_lehmer_code(uint16_t i, uint16_t a0, uint16_t a1, uint16_t a2, uint16_t a3) {
    switch (i) {
        case 0:
            return 0;
        case 1:
            return 2047 ^ (a1 | a3);
        case 2:
            return 2047 ^ (a0 | a3);
        case 3:
            return a3 ^ (a3 | a0 ^ a1);
        case 4:
            return 2047 ^ (a3 | a0 ^ a1);
        case 5:
            return a0 ^ a0 & a3;
        case 6:
            return a1 & (a1 ^ a3);
        case 7:
            return a3 ^ 2047;
        case 8:
            return 2047 ^ (a0 | a1 | a2 & a3);
        case 9:
            return a1 ^ (a1 | a3 ^ (a0 | a2 & a3));
        case 10:
            return a0 ^ (a0 | a3 ^ (a1 | a2 & a3));
        case 11:
            return (a0 | a1 | a2) ^ (a3 | a0 & a1);
        case 12:
            return (a2 ^ a3) & (a1 ^ a3) & (a0 ^ a3);
        case 13:
            return a3 ^ (a0 | a2 ^ a1 & (a2 ^ a3));
        case 14:
            return a3 ^ (a1 | a2 ^ a0 & (a2 ^ a3));
        case 15:
            return a3 ^ (a0 | a1 | a2 & a3);
        case 16:
            return a1 ^ (a1 | a2 ^ (a0 | a2 & a3));
        case 17:
            return a0 & (a2 ^ a3) & (a0 ^ a1);
        case 18:
            return (a2 ^ a3) & (a0 ^ a1) & (a1 ^ a3);
        case 19:
            return a2 ^ (a2 & a3 | a0 & (a1 ^ a3));
        case 20:
            return a0 & (a3 ^ (a1 | a2 & a3));
        case 21:
            return (a0 | a1 ^ a2) & (a3 ^ (a1 | a2));
        case 22:
            return a2 ^ (a2 & a3 | a0 ^ a0 & a1);
        case 23:
            return (a0 | a1) & (a3 ^ (a1 | a2));
        case 24:
            return 2047 ^ (a1 | a2);
        case 25:
            return a1 ^ (a1 | a2 ^ a3);
        case 26:
            return (a1 | a2) ^ (a0 | a3);
        case 27:
            return (a2 ^ a3) & (a1 ^ (a0 | a3));
        case 28:
            return (a1 | a2) ^ (a3 | a0 ^ a1);
        case 29:
            return a3 ^ (a1 | a2) & (a0 | a3);
        case 30:
            return a3 ^ (a1 | a2 & a3);
        case 31:
            return a3 ^ (a1 | a2);
        case 32:
            return a0 ^ (a0 | a2 ^ (a1 | a2 & a3));
        case 33:
            return (a2 ^ a3) & (a0 ^ a1) & (a0 ^ a3);
        case 34:
            return a0 ^ (a0 | a1 & (a2 ^ a3));
        case 35:
            return a2 ^ (a2 & a3 | a1 & (a0 ^ a3));
        case 36:
            return a1 & (a3 ^ (a0 | a2 & a3));
        case 37:
            return a2 ^ (a2 & a3 | a0 ^ (a0 | a1));
        case 38:
            return (a1 | a0 ^ a2) & (a3 ^ (a0 | a2));
        case 39:
            return (a0 | a1) & (a3 ^ (a0 | a2));
        case 40:
            return 2047 ^ (a0 | a2);
        case 41:
            return (a1 | a3) ^ (a0 | a2);
        case 42:
            return a0 ^ (a0 | a2 ^ a3);
        case 43:
            return (a2 ^ a3) & (a0 ^ (a1 | a3));
        case 44:
            return (a0 | a2) ^ (a3 | a0 ^ a1);
        case 45:
            return a3 ^ (a0 | a2 & a3);
        case 46:
            return a3 ^ (a1 | a3) & (a0 | a2);
        case 47:
            return a3 ^ (a0 | a2);
        case 48:
            return a2 ^ (a2 | a0 ^ a1);
        case 49:
            return (a2 ^ a3) & (a1 ^ (a0 | a2));
        case 50:
            return (a1 | a2) ^ (a0 | a2 & a3);
        case 51:
            return (a2 ^ a3) & (a0 ^ a1);
        case 52:
            return a2 ^ (a2 & a3 | a0 ^ a1);
        case 53:
            return (a2 ^ a3) & (a0 ^ a1 & a3);
        case 54:
            return (a2 ^ a3) & (a1 ^ a0 & a3);
        case 55:
            return a2 ^ a3 & (a2 | a0 ^ a1);
        case 56:
            return (a0 | a1 | a3) ^ (a2 | a0 & a1);
        case 57:
            return a3 ^ (a2 & a3 | a0 & (a1 ^ a2));
        case 58:
            return a3 ^ (a2 & a3 | a1 & (a0 ^ a2));
        case 59:
            return 2047 ^ (a2 & a3 | a0 & a1);
        case 60:
            return a3 ^ (a2 & a3 | a0 & a1);
        case 61:
            return 2047 ^ (a2 & a3 | a1 & (a0 ^ a2));
        case 62:
            return 2047 ^ (a2 & a3 | a0 & (a1 ^ a2));
        case 63:
            return (a2 ^ a3) & (a0 ^ a1 | a1 ^ a3);
        case 64:
            return (a2 ^ a3) & (a0 ^ a2) & (a1 ^ a2);
        case 65:
            return a0 & (a2 ^ (a1 | a2 & a3));
        case 66:
            return a1 & (a2 ^ (a0 | a2 & a3));
        case 67:
            return a2 ^ (a2 & a3 | a0 & a1);
        case 68:
            return a0 & a1 & (a2 ^ a3);
        case 69:
            return a2 ^ (a2 & a3 | a1 & (a0 ^ a2));
        case 70:
            return a2 ^ (a2 & a3 | a0 & (a1 ^ a2));
        case 71:
            return (a0 | a1) & (a3 ^ (a2 | a0 ^ a1));
        case 72:
            return 2047 ^ (a2 | a0 ^ a1);
        case 73:
            return (a1 | a3) ^ (a2 | a0 ^ a1);
        case 74:
            return (a0 | a3) ^ (a2 | a0 ^ a1);
        case 75:
            return a3 ^ (a2 & a3 | a0 ^ a1);
        case 76:
            return 2047 ^ (a2 & a3 | a0 ^ a1);
        case 77:
            return a3 ^ (a2 & a3 | a0 ^ a1 & a3);
        case 78:
            return a3 ^ (a2 & a3 | a1 ^ a0 & a3);
        case 79:
            return a3 ^ (a2 | a0 ^ a1);
        case 80:
            return a0 & (a0 ^ a2);
        case 81:
            return a2 ^ (a1 | a3) & (a0 | a2);
        case 82:
            return a2 ^ (a0 | a2 & a3);
        case 83:
            return (a2 ^ a3) & (a0 ^ a1 & a2);
        case 84:
            return a2 ^ (a2 & a3 | a0 ^ a1 & a2);
        case 85:
            return a0 & (a2 ^ a3);
        case 86:
            return a0 ^ a1 ^ a0 & a2 ^ a1 & a3;
        case 87:
            return a2 ^ a3 & (a0 | a2);
        case 88:
            return a2 ^ (a0 | a3 ^ a1 & (a2 ^ a3));
        case 89:
            return (a0 | a1 ^ a3) & (a2 ^ (a1 | a3));
        case 90:
            return a2 ^ (a0 | 2047 ^ a1 & (a2 ^ a3));
        case 91:
            return 2047 ^ (a2 & a3 | a1 & (a0 ^ a3));
        case 92:
            return a3 ^ (a2 & a3 | a1 & (a0 ^ a3));
        case 93:
            return (a2 ^ a3) & (a0 | a1 ^ 2047);
        case 94:
            return (a2 ^ a3) & (a0 ^ a2 | a1 ^ a3);
        case 95:
            return (a2 ^ a3) & (a0 | a1 ^ a3);
        case 96:
            return a1 ^ a1 & a2;
        case 97:
            return a2 ^ (a1 | a2 & a3);
        case 98:
            return a2 ^ (a1 | a2) & (a0 | a3);
        case 99:
            return (a2 ^ a3) & (a1 ^ a0 & a2);
        case 100:
            return a2 ^ (a1 | a2) & (a3 | a0 ^ a1);
        case 101:
            return a0 ^ a1 ^ a1 & a2 ^ a0 & a3;
        case 102:
            return a1 & (a2 ^ a3);
        case 103:
            return a2 ^ a3 & (a1 | a2);
        case 104:
            return a2 ^ (a1 | a3 ^ a0 & (a2 ^ a3));
        case 105:
            return a2 ^ (a1 | 2047 ^ a0 & (a2 ^ a3));
        case 106:
            return (a1 | a0 ^ a3) & (a2 ^ (a0 | a3));
        case 107:
            return 2047 ^ (a2 & a3 | a0 & (a1 ^ a3));
        case 108:
            return a3 ^ (a2 & a3 | a0 & (a1 ^ a3));
        case 109:
            return (a2 ^ a3) & (a1 ^ a2 | a0 ^ a3);
        case 110:
            return (a2 ^ a3) & (a1 | ~a0);
        case 111:
            return (a2 ^ a3) & (a1 | a0 ^ a3);
        case 112:
            return a2 ^ (a0 | a1 | a2 & a3);
        case 113:
            return (a0 | a1) & (a2 ^ (a1 | a3));
        case 114:
            return (a0 | a1) & (a2 ^ (a0 | a3));
        case 115:
            return (a2 ^ a3) & (a0 ^ a2 | a0 ^ a1);
        case 116:
            return (a0 | a1) & (a2 ^ (a3 | a0 ^ a1));
        case 117:
            return (a2 ^ a3) & (a0 | a1 ^ a2);
        case 118:
            return (a2 ^ a3) & (a1 | a0 ^ a2);
        case 119:
            return (a2 ^ a3) & (a0 | a1);
        case 120:
            return a2 ^ 2047;
        case 121:
            return a2 ^ (a1 | a3);
        case 122:
            return a2 ^ (a0 | a3);
        case 123:
            return a2 ^ (a3 | a0 ^ a1 ^ 2047);
        case 124:
            return a2 ^ (a3 | a0 ^ a1);
        case 125:
            return a2 ^ (a3 | a0 ^ a2);
        case 126:
            return a2 ^ (a3 | a1 ^ 2047);
        case 127:
            return a2 ^ a3;
        case 128:
            return a2 & ~(a0 | a1);
        case 129:
            return a1 ^ (a1 | a2 & (a0 ^ a3));
        case 130:
            return a0 ^ (a0 | a2 & (a1 ^ a3));
        case 131:
            return a0 ^ (a2 & (a1 ^ a3) | a0 ^ a3 ^ 2047);
        case 132:
            return a2 & (a1 ^ a3) & (a0 ^ a3);
        case 133:
            return a2 & (a1 ^ 2047 ^ a0 & (a1 ^ a3));
        case 134:
            return a2 ^ a2 & (a0 ^ a1 & (a0 ^ a3));
        case 135:
            return a2 & (a3 ^ (a0 | a1));
        case 136:
            return a3 & ~(a0 | a1);
        case 137:
            return 2047 ^ (a1 | a0 & a3);
        case 138:
            return 2047 ^ (a0 | a1 & a3);
        case 139:
            return a0 ^ (a0 & a1 | a1 ^ a3);
        case 140:
            return a0 ^ (a1 ^ 2047 | a0 & a3);
        case 141:
            return a3 ^ (a0 | a1 & a3);
        case 142:
            return a3 ^ (a1 | a0 & a3);
        case 143:
            return 2047 ^ a3 & (a0 | a1);
        case 144:
            return a1 ^ (a1 | a3 & (a0 ^ a2));
        case 145:
            return a1 ^ (a1 | a2 ^ a0 & a3);
        case 146:
            return (a1 | a2) ^ (a0 | a1 & a3);
        case 147:
            return a0 ^ (a0 & a1 | a2 & (a1 ^ a3));
        case 148:
            return a1 ^ (a0 ^ a2 | a1 & a3);
        case 149:
            return a0 ^ a3 & (a2 ^ a1 & (a0 ^ a2));
        case 150:
            return a1 ^ a3 & (a1 | a0 ^ a2);
        case 151:
            return (a1 | a2) ^ a3 & (a0 | a1);
        case 152:
            return 2047 ^ (a1 | a0 & a2);
        case 153:
            return a1 ^ (a1 | a3 ^ a0 & a2);
        case 154:
            return (a0 | a3) ^ (a1 | a0 & a2);
        case 155:
            return a0 ^ 2047 ^ (a0 ^ a1) & (a3 ^ a0 & a2);
        case 156:
            return (a1 ^ a3) & (a3 ^ a0 & a2);
        case 157:
            return a1 ^ 2047 ^ a0 & a2 & (a1 ^ a3);
        case 158:
            return a3 ^ (a1 | a2 ^ a2 & (a0 ^ a3));
        case 159:
            return a3 ^ (a1 | a0 & a2);
        case 160:
            return a0 ^ (a0 | a3 & (a1 ^ a2));
        case 161:
            return (a0 | a2) ^ (a1 | a0 & a3);
        case 162:
            return a0 ^ (a0 | a2 ^ a1 & a3);
        case 163:
            return a0 ^ (a0 & a3 | a1 ^ a2 & a3);
        case 164:
            return a0 ^ (a1 ^ a2 | a0 & a3);
        case 165:
            return a0 ^ a3 & (a0 | a1 ^ a2);
        case 166:
            return a1 ^ a3 & (a2 ^ a0 & (a1 ^ a2));
        case 167:
            return (a0 | a2) ^ a3 & (a0 | a1);
        case 168:
            return 2047 ^ (a0 | a1 & a2);
        case 169:
            return (a1 | a3) ^ (a0 | a1 & a2);
        case 170:
            return a0 ^ (a0 | a3 ^ a1 & a2);
        case 171:
            return a0 ^ 2047 ^ a2 & (a0 ^ a1) & (a0 ^ a3);
        case 172:
            return (a0 ^ a3) & (a3 ^ a1 & a2);
        case 173:
            return a3 ^ (a0 | a2 & (a1 ^ a3 ^ 2047));
        case 174:
            return a0 ^ 2047 ^ a1 & a2 & (a0 ^ a3);
        case 175:
            return a3 ^ (a0 | a1 & a2);
        case 176:
            return a0 ^ (a0 & a1 | a1 ^ a2);
        case 177:
            return a0 ^ (a0 & a1 | a3 & (a1 ^ a2));
        case 178:
            return a0 ^ (a0 & a2 | a1 ^ a2 & a3);
        case 179:
            return a2 ^ a0 & a3 ^ a1 & (a3 ^ a0 & a2);
        case 180:
            return (a3 ^ a1 & a2) & (a0 ^ a1 ^ a2);
        case 181:
            return a1 ^ a2 ^ a0 & (a3 ^ a1 & a2);
        case 182:
            return a0 ^ a2 ^ a1 & (a3 ^ a0 & a2);
        case 183:
            return a0 ^ a1 ^ a2 & (a3 ^ a0 & a1);
        case 184:
            return a0 ^ (a3 & (a1 ^ a2) | a0 ^ a2 ^ 2047);
        case 185:
            return a0 ^ 2047 ^ (a0 ^ a1) & (a2 ^ a0 & a3);
        case 186:
            return a0 ^ 2047 ^ a3 & (a0 ^ a2) & (a0 ^ a1);
        case 187:
            return a3 ^ a0 & a2 ^ a1 & (a2 ^ a0 & a3);
        case 188:
            return a0 ^ (a1 ^ a2 | a3 & (a0 ^ a1 ^ a3));
        case 189:
            return a0 ^ a3 & (a3 ^ (a0 ^ a2) & (a0 ^ a1));
        case 190:
            return a0 ^ a3 ^ (a0 ^ a1) & (a2 ^ a0 & a3);
        case 191:
            return a0 ^ (a0 ^ a2 ^ a3 | a3 & (a1 ^ a2));
        case 192:
            return a3 & (a0 ^ a2) & (a1 ^ a2);
        case 193:
            return (a1 ^ a2) & (a2 ^ a0 & a3);
        case 194:
            return (a0 ^ a2) & (a2 ^ a1 & a3);
        case 195:
            return (a0 ^ a1 ^ a3) & (a2 ^ a1 & a3);
        case 196:
            return (a2 ^ a1 & a3) & (a0 ^ a1 ^ 2047);
        case 197:
            return (a2 ^ a1 & a3) & (a0 ^ a2 & a3);
        case 198:
            return (a1 ^ a2 & a3) & (a2 ^ a0 & a3);
        case 199:
            return a3 ^ 2047 | (a0 ^ a2) & (a1 ^ a2);
        case 200:
            return a0 ^ (a0 & a2 | a1 ^ 2047);
        case 201:
            return a1 ^ (a1 & a2 | a0 ^ a3);
        case 202:
            return a0 ^ (a0 & a2 | a1 ^ a3);
        case 203:
            return a0 ^ (a1 ^ a3 | a2 ^ a2 & (a0 ^ a1));
        case 204:
            return (a3 ^ a1 & a2) & (a0 ^ a1 ^ 2047);
        case 205:
            return a1 ^ 2047 ^ a0 & (a3 ^ a1 & a2);
        case 206:
            return a0 ^ 2047 ^ a1 & (a3 ^ a0 & a2);
        case 207:
            return a3 ^ (a0 & a2 | a0 ^ a1);
        case 208:
            return a2 ^ (a0 | a1 & a2);
        case 209:
            return a0 ^ a2 & (a3 ^ a1 & (a0 ^ a3));
        case 210:
            return a0 ^ a2 & (a0 | a1 ^ a3);
        case 211:
            return a0 ^ a2 & (2047 ^ (a0 ^ a1) & (a0 ^ a3));
        case 212:
            return (a0 ^ a2 & a3) & (a3 ^ a1 & a2);
        case 213:
            return a2 ^ (a0 & a3 | a1 & (a0 ^ a2));
        case 214:
            return a0 ^ a2 & (2047 ^ a1 & (a0 ^ a3));
        case 215:
            return a2 & a3 ^ (a0 | a1 & a2);
        case 216:
            return a2 ^ (a0 | a1 ^ a2 ^ (a1 | a3));
        case 217:
            return a1 ^ 2047 ^ a0 & a3 & (a1 ^ a2);
        case 218:
            return a2 ^ (a0 | a2 ^ 2047 ^ a1 & a3);
        case 219:
            return a1 ^ a3 ^ a0 & (a2 ^ a1 & a3);
        case 220:
            return a1 ^ 2047 ^ a0 & (a2 ^ a1 & a3);
        case 221:
            return a3 ^ (a0 & a2 | a1 & (a0 ^ a3));
        case 222:
            return a1 ^ a3 & (2047 ^ a0 & (a1 ^ a2));
        case 223:
            return a2 ^ a3 & (a0 | a1 ^ ~a2);
        case 224:
            return a2 ^ (a1 | a0 & a2);
        case 225:
            return a1 ^ a2 & (a1 | a0 ^ a3);
        case 226:
            return a1 ^ a2 & (a3 ^ a0 & (a1 ^ a3));
        case 227:
            return a0 ^ a2 ^ (a0 ^ a1) & (a3 ^ a0 & a2);
        case 228:
            return (a1 ^ a2 & a3) & (a3 ^ a0 & a2);
        case 229:
            return a1 ^ a2 & (2047 ^ a0 & (a1 ^ a3));
        case 230:
            return a2 ^ (a1 & a3 | a0 & (a1 ^ a2));
        case 231:
            return a2 & a3 ^ (a1 | a0 & a2);
        case 232:
            return a2 ^ (a1 | a0 ^ a2 ^ (a0 | a3));
        case 233:
            return a2 ^ (a1 | a2 ^ 2047 ^ a0 & a3);
        case 234:
            return a0 ^ 2047 ^ a1 & a3 & (a0 ^ a2);
        case 235:
            return a0 ^ a3 ^ a1 & (a2 ^ a0 & a3);
        case 236:
            return a0 ^ 2047 ^ a1 & (a2 ^ a0 & a3);
        case 237:
            return a0 ^ a3 & ~(a1 & (a0 ^ a2));
        case 238:
            return a3 ^ (a1 & a2 | a0 & (a1 ^ a3));
        case 239:
            return a2 ^ a3 & (a1 | a0 ^ a2 ^ a3);
        case 240:
            return a3 & (a2 ^ (a0 | a1));
        case 241:
            return a2 ^ (a1 | a0 & a3);
        case 242:
            return a2 ^ (a0 | a1 & a3);
        case 243:
            return a0 ^ a1 ^ a3 & (a2 ^ a0 & a1);
        case 244:
            return a2 ^ (a0 ^ a1 | a0 & a3);
        case 245:
            return a2 & a3 ^ (a0 | a1 & a3);
        case 246:
            return a2 & a3 ^ (a1 | a0 & a3);
        case 247:
            return a2 ^ a3 & (a0 | a1);
        case 248:
            return 2047 ^ a2 & (a0 | a1);
        case 249:
            return (a1 | a3) ^ a2 & (a0 | a1);
        case 250:
            return (a0 | a3) ^ a2 & (a0 | a1);
        case 251:
            return a0 ^ (a2 & (a1 ^ a3) | a0 ^ a2 ^ a3);
        case 252:
            return a2 ^ 2047 | (a1 ^ a3) & (a0 ^ a3);
        case 253:
            return a3 ^ a2 & (a0 | a1 ^ a3 ^ 2047);
        case 254:
            return a3 ^ a2 & (a1 | a0 ^ a2 ^ a3);
        case 255:
            return a3 ^ a2 & (a0 | a1);
        case 256:
            return a2 & (2047 ^ (a1 | a0 ^ a3));
        case 257:
            return a0 & a2 & (a0 ^ a1);
        case 258:
            return a2 & (a0 ^ a1) & (a1 ^ a3);
        case 259:
            return a1 ^ (a0 & a2 | a1 ^ a3 ^ 2047);
        case 260:
            return a0 & a2 & (a1 ^ a3);
        case 261:
            return a0 ^ 2047 ^ (a0 ^ a3 | a2 & (a0 ^ a1));
        case 262:
            return a2 & (a3 ^ (a1 | a0 ^ a2));
        case 263:
            return a2 & (a3 ^ (a1 | a0 ^ a3));
        case 264:
            return a3 & (a3 ^ (a1 | a0 ^ a2));
        case 265:
            return 2047 ^ (a1 | a3 & (a0 ^ a2));
        case 266:
            return a3 ^ (a0 ^ a2 | a1 & a3);
        case 267:
            return a1 ^ (a1 & a3 | a0 ^ a2 ^ 2047);
        case 268:
            return a1 ^ (a1 & a3 | a0 ^ a2 ^ a3);
        case 269:
            return 2047 ^ (a0 ^ a2 | a1 & a3);
        case 270:
            return a3 ^ (a1 | a3 & (a0 ^ a2));
        case 271:
            return a3 ^ (a1 | a2 ^ a0 & a3);
        case 272:
            return a0 & a3 & (a0 ^ a1);
        case 273:
            return a1 ^ (a0 | a1 | a3 ^ 2047);
        case 274:
            return a0 ^ (a0 & a1 | a3 ^ 2047);
        case 275:
            return a1 ^ (a0 | a1 & a3);
        case 276:
            return a1 ^ a3 ^ 2047 ^ (a0 | a1 & a3);
        case 277:
            return a0 & (a0 ^ a1 & a3);
        case 278:
            return a1 ^ a3 & (a0 | a1);
        case 279:
            return a3 ^ (a1 | 2047 ^ a0 & a3);
        case 280:
            return 2047 ^ (a1 | a2 & (a0 ^ a3));
        case 281:
            return a1 ^ (a0 | a1 | a2 ^ 2047);
        case 282:
            return (a0 | a3) ^ (a1 | a2 & (a0 ^ a3));
        case 283:
            return a1 ^ (a0 | a1 ^ a3 ^ (a1 | a2));
        case 284:
            return (a1 ^ a3) & (a0 | a2 ^ 2047);
        case 285:
            return a0 ^ 2047 ^ (a0 ^ a1 | a2 & (a1 ^ a3));
        case 286:
            return a3 ^ (a1 | a0 ^ (a0 | a2));
        case 287:
            return a3 ^ (a1 | a2 & (a0 ^ a3));
        case 288:
            return a3 & (a0 ^ a1) & (a1 ^ a2);
        case 289:
            return (a0 | a2) ^ (a1 | a3 & (a0 ^ a2));
        case 290:
            return (a2 ^ a1 & a3) & (a0 ^ a2 ^ a3);
        case 291:
            return (a0 ^ a1) & (a2 ^ a1 & a3);
        case 292:
            return a3 ^ 2047 ^ (a0 ^ a1) & (a2 ^ a1 & a3);
        case 293:
            return (a0 | a2) ^ (a0 ^ a2 | a1 & a3);
        case 294:
            return (a1 ^ a2 & a3) & (a1 ^ a0 & a3);
        case 295:
            return (a0 | a2) ^ a3 & (a1 | a0 ^ a2);
        case 296:
            return a2 ^ (a1 & a2 | a0 ^ a3);
        case 297:
            return a0 ^ (a0 & a1 | a2 ^ 2047);
        case 298:
            return (a3 ^ a1 & a2) & (a0 ^ a2 ^ a3);
        case 299:
            return a0 ^ (a0 & a1 | a2 ^ (a0 | a3));
        case 300:
            return a2 ^ 2047 ^ a0 & (a3 ^ a1 & a2);
        case 301:
            return a0 ^ a2 ^ (a0 ^ a1 | a3 ^ a1 & a2);
        case 302:
            return a3 ^ (a0 ^ a2 | a0 & a1);
        case 303:
            return a3 ^ (a1 & a2 | a0 ^ a2 & a3);
        case 304:
            return a1 ^ (a1 & a2 | a0 ^ a3 ^ 2047);
        case 305:
            return a1 ^ (a0 | a1 & a2);
        case 306:
            return (a0 ^ a1) & (a3 ^ a1 & a2);
        case 307:
            return a1 ^ (a0 | a2 & (a1 ^ a3 ^ 2047));
        case 308:
            return a1 ^ (a0 & a3 | a1 & (a0 ^ a2));
        case 309:
            return a0 ^ 2047 ^ (a1 ^ a3 | a2 & (a0 ^ a1));
        case 310:
            return a1 ^ a3 ^ 2047 ^ (a0 | a1 & a2);
        case 311:
            return a1 & a3 ^ (a0 | a1 & a2);
        case 312:
            return a1 ^ (a0 & a3 | a1 ^ a2 ^ 2047);
        case 313:
            return a1 ^ (a0 | a1 ^ a2 ^ (a1 | a3));
        case 314:
            return a0 ^ (a0 & a1 | a3 ^ (a0 | a2));
        case 315:
            return a1 ^ (a0 | a2 ^ 2047 ^ a1 & a3);
        case 316:
            return a0 ^ a1 ^ a3 ^ (a0 | a2 ^ a1 & a3);
        case 317:
            return a2 ^ 2047 ^ a0 & (a2 ^ a1 & a3);
        case 318:
            return a1 ^ a3 & (a0 | a1 ^ ~a2);
        case 319:
            return a1 ^ (a0 & a3 | a1 ^ a2 ^ a3);
        case 320:
            return a0 & a3 & (a1 ^ a2);
        case 321:
            return (a1 ^ a2) & (a0 | ~a3);
        case 322:
            return a2 ^ (a0 & a1 | a2 & (a0 ^ a3));
        case 323:
            return a1 ^ (a0 & a2 | a1 & (a0 ^ a3));
        case 324:
            return a0 ^ a1 ^ a2 ^ a3 & (a0 | a1 ^ a2);
        case 325:
            return a0 & (a2 ^ a1 & a3);
        case 326:
            return a1 ^ a3 & (a1 ^ a0 & (a1 ^ a2));
        case 327:
            return a3 ^ 2047 | a0 & (a1 ^ a2);
        case 328:
            return a1 ^ (a1 & a2 | a0 ^ a2 ^ a3);
        case 329:
            return a1 ^ a2 ^ 2047 ^ (a0 | a1 & a2);
        case 330:
            return a2 ^ 2047 ^ (a0 ^ a1) & (a3 ^ a1 & a2);
        case 331:
            return a0 ^ a1 ^ a2 ^ (a0 | a3 ^ a1 & a2);
        case 332:
            return a0 ^ a1 ^ a3 ^ a2 & (a0 | a1 ^ a3);
        case 333:
            return a0 ^ a2 ^ (a1 ^ a3 | a2 & (a0 ^ a1));
        case 334:
            return a1 ^ a2 ^ a3 ^ (a0 | a1 & a2);
        case 335:
            return a0 ^ a1 ^ (a2 ^ 2047 | a1 & (a0 ^ a3));
        case 336:
            return 2047 ^ (a1 & a2 | a0 ^ a3);
        case 337:
            return a0 & ~(a1 & a2);
        case 338:
            return (a0 | a3) ^ (a1 & a2 | a0 ^ a3);
        case 339:
            return a2 ^ (a0 & a1 | a3 & (a0 ^ a2));
        case 340:
            return a0 & (a3 ^ a1 & a2);
        case 341:
            return a0 ^ a2 ^ a2 & (a0 ^ a1 | a1 ^ a3);
        case 342:
            return a3 ^ (a1 & a2 | a0 ^ 2047);
        case 343:
            return a3 ^ (a1 & a2 | a0 ^ a3);
        case 344:
            return a0 ^ 2047 ^ (a0 ^ a2 | a3 & (a0 ^ a1));
        case 345:
            return a0 ^ 2047 ^ (a0 ^ a1 | a3 & (a1 ^ a2));
        case 346:
            return a0 ^ a3 ^ (a0 ^ a2 | a0 ^ a1 & a3);
        case 347:
            return a0 ^ 2047 ^ (a1 ^ a2 | a3 & (a0 ^ a1));
        case 348:
            return a0 ^ a3 ^ (a1 ^ a2 | a3 & (a0 ^ a1));
        case 349:
            return a0 ^ a3 & ~(a0 ^ a2 | a0 ^ a1);
        case 350:
            return a0 ^ a3 ^ (a0 ^ a1 | a3 & (a1 ^ a2));
        case 351:
            return a3 ^ (a1 | a2) | a0 & (a1 ^ a2);
        case 352:
            return a2 ^ (a1 | a2 & (a0 ^ a3));
        case 353:
            return a1 ^ a2 & (a0 | a1);
        case 354:
            return (a1 ^ a2 & a3) & (a1 ^ a0 & a2);
        case 355:
            return a1 ^ a2 & (a0 | a1 ^ a3 ^ 2047);
        case 356:
            return a1 ^ a2 & (a1 ^ a0 & (a1 ^ a3));
        case 357:
            return a0 ^ a2 ^ (a0 ^ a1 | a2 & (a1 ^ a3));
        case 358:
            return a1 ^ a2 ^ a2 & (a3 ^ (a0 | a1));
        case 359:
            return (a0 | a1) & (a2 ^ a1 & a3);
        case 360:
            return a2 ^ (a1 | 2047 ^ a0 & a3);
        case 361:
            return a2 ^ (a1 | a0 ^ (a0 | a3));
        case 362:
            return a2 ^ (a0 & a1 | a0 ^ a3);
        case 363:
            return a1 ^ a2 ^ 2047 ^ (a0 | a1 & a3);
        case 364:
            return a1 ^ a2 ^ a3 ^ (a0 | a1 & a3);
        case 365:
            return a2 ^ (a0 ^ 2047 | a1 & a3);
        case 366:
            return a1 ^ a2 ^ 2047 ^ a3 & (a0 | a1);
        case 367:
            return a2 ^ a3 & (a1 | a0 ^ a3);
        case 368:
            return a2 ^ (a1 | a2 ^ a0 & a3);
        case 369:
            return a2 ^ (a1 | a3 & (a0 ^ a2));
        case 370:
            return a2 ^ (a1 & a3 | a0 ^ a2 & a3);
        case 371:
            return a1 & a2 ^ (a0 | a1 & a3);
        case 372:
            return a0 ^ a1 ^ (a3 ^ 2047 | a1 & (a0 ^ a2));
        case 373:
            return a2 ^ (a0 ^ a2 | a1 & a3);
        case 374:
            return a1 & a2 ^ a3 & (a0 | a1);
        case 375:
            return a2 ^ a3 & (a1 | a0 ^ a2);
        case 376:
            return a2 ^ (a1 | a3 ^ a0 & a2);
        case 377:
            return a2 ^ (a1 | 2047 ^ a0 & a2);
        case 378:
            return (a0 | a3) ^ a2 & (a1 | a0 ^ a3);
        case 379:
            return a1 ^ (a0 & a2 | a1 ^ a2 ^ a3);
        case 380:
            return a2 ^ 2047 | a0 & (a1 ^ a3);
        case 381:
            return a0 & (a1 ^ a3) | a2 ^ (a1 | a3);
        case 382:
            return a3 ^ a2 & (a1 | a0 ^ a2);
        case 383:
            return a3 ^ a2 & (a1 | a0 ^ a3);
        case 384:
            return a1 ^ (a1 | a2 & a3);
        case 385:
            return a1 ^ (a1 | a2);
        case 386:
            return (a0 | a3) ^ (a1 | a2 ^ a3);
        case 387:
            return a2 & (a1 ^ (a0 | a3));
        case 388:
            return a2 & (a1 ^ (a3 | a0 ^ a2));
        case 389:
            return a2 & (a1 ^ (a3 | a0 ^ a1));
        case 390:
            return a2 & (a1 ^ a3);
        case 391:
            return a2 & (a2 ^ a1 & a3);
        case 392:
            return 2047 ^ (a1 | a0 & (a2 ^ a3));
        case 393:
            return a1 ^ (a1 | a3 ^ a0 & (a2 ^ a3));
        case 394:
            return (a0 | a3) ^ (a1 | a0 & (a2 ^ a3));
        case 395:
            return a1 ^ (a2 & a3 | a1 ^ a2 | a0 ^ a3);
        case 396:
            return (a1 ^ a3) & (a3 ^ a0 & (a2 ^ a3));
        case 397:
            return a1 ^ 2047 ^ a0 & (a3 ^ (a1 | a2 & a3));
        case 398:
            return a3 ^ (a1 | a2 ^ (a0 | a2 & a3));
        case 399:
            return a3 ^ (a1 | a0 & (a2 ^ a3));
        case 400:
            return a1 ^ (a1 | a2 ^ a0 & (a2 ^ a3));
        case 401:
            return a1 ^ (a0 | a1 | a2 & a3);
        case 402:
            return (a0 | a2) & (a1 ^ (a3 | a0 & a1));
        case 403:
            return a1 ^ (a0 | a2 ^ a1 & (a2 ^ a3));
        case 404:
            return (a1 ^ a3) & (a0 | a2 & a3);
        case 405:
            return (a0 | a1 ^ a2) & (2047 ^ a1 & a3);
        case 406:
            return a1 ^ a2 ^ (a2 ^ a3) & (a0 | a1);
        case 407:
            return a3 ^ (a1 | a3 ^ (a0 | a2 & a3));
        case 408:
            return a1 ^ (a1 | a3);
        case 409:
            return a1 ^ 2047;
        case 410:
            return a0 ^ 2047 ^ a3 & (a0 ^ a1);
        case 411:
            return a1 ^ (a0 | a3);
        case 412:
            return a1 ^ (a3 | a0 ^ a2);
        case 413:
            return a1 ^ (a3 | a0 ^ a1);
        case 414:
            return a1 ^ a3;
        case 415:
            return 2047 ^ a1 & a3;
        case 416:
            return (a0 | a2) ^ (a1 | a0 & (a2 ^ a3));
        case 417:
            return (a0 | a3) & (a1 ^ (a2 | a0 & a1));
        case 418:
            return a1 ^ (a2 & a3 | a0 & a1);
        case 419:
            return a2 ^ a1 & (a3 ^ a0 & (a2 ^ a3));
        case 420:
            return a1 ^ (a2 & a3 | a1 & (a0 ^ a2));
        case 421:
            return a1 ^ a2 ^ a0 & a1 & (a2 ^ a3);
        case 422:
            return a1 ^ (a2 & a3 | (a0 ^ a2) & (a1 ^ a2));
        case 423:
            return a1 ^ (a2 & a3 | a0 & (a1 ^ a2));
        case 424:
            return (a0 | a2) ^ (a1 | a2 ^ a3);
        case 425:
            return a0 ^ 2047 ^ a2 & (a0 ^ a1);
        case 426:
            return a0 ^ 2047 ^ a2 & a3 & (a0 ^ a1);
        case 427:
            return a0 ^ a3 ^ a2 & (a1 ^ a0 & a3);
        case 428:
            return a0 ^ 2047 ^ a2 & (a1 ^ a0 & a3);
        case 429:
            return a0 ^ a2 ^ (a2 ^ a3 | a0 ^ a1);
        case 430:
            return a0 ^ a3 ^ a2 & (a0 ^ a1);
        case 431:
            return a0 ^ 2047 ^ a2 & (a0 ^ a1 & a3);
        case 432:
            return a3 & (a1 ^ (a0 | a2));
        case 433:
            return a1 ^ (a0 | a2);
        case 434:
            return a0 ^ a2 ^ a3 & (a1 ^ a0 & a2);
        case 435:
            return a1 ^ (a0 | a2 & a3);
        case 436:
            return a1 ^ a2 ^ a0 & (a2 ^ a3);
        case 437:
            return a1 & a3 ^ (a0 | a2 & a3);
        case 438:
            return a1 ^ a3 & (a0 | a2);
        case 439:
            return (a0 | a2) ^ a1 & a3;
        case 440:
            return a1 ^ (a2 & a3 | a0 ^ a2 | a1 ^ a3);
        case 441:
            return a1 ^ (a0 | a3 ^ a1 & (a2 ^ a3));
        case 442:
            return a3 ^ a1 & (a2 ^ a0 & (a2 ^ a3));
        case 443:
            return 2047 ^ a1 & (a0 | a2 & a3);
        case 444:
            return a3 ^ a1 & (a0 | a2 & a3);
        case 445:
            return 2047 ^ a1 & (a2 ^ a0 & (a2 ^ a3));
        case 446:
            return a1 ^ a3 | 2047 ^ (a0 | a1 & a2);
        case 447:
            return a1 ^ a3 | (a2 ^ a3) & (a0 ^ a1);
        case 448:
            return (a1 ^ a2) & (a0 ^ a2 | a1 ^ a3);
        case 449:
            return (a1 ^ a2) & (a0 | a2 & a3);
        case 450:
            return a1 ^ (a2 & a3 | a1 & (a0 ^ a3));
        case 451:
            return a2 ^ a1 & (a0 | a2 & a3);
        case 452:
            return a1 ^ (a2 & a3 | a0 ^ (a0 | a1));
        case 453:
            return a2 ^ a1 & (a2 ^ a0 & (a2 ^ a3));
        case 454:
            return a1 ^ a2 ^ (a0 | a1) & (a3 ^ (a0 | a2));
        case 455:
            return (a2 ^ a1 & a3) & (a0 | a1 ^ a3);
        case 456:
            return a3 & (a1 ^ (a2 | ~a0));
        case 457:
            return a1 ^ (a2 | a0 ^ 2047);
        case 458:
            return a0 ^ 2047 ^ a3 & (a1 ^ a0 & a2);
        case 459:
            return a1 ^ a3 ^ a0 & (a2 ^ a3);
        case 460:
            return a1 ^ 2047 ^ a0 & (a2 ^ a3);
        case 461:
            return a0 ^ a3 & (a1 ^ ~(a0 & a2));
        case 462:
            return a0 ^ a1 ^ a3 ^ a0 & a2;
        case 463:
            return a1 & a3 ^ (a2 | a0 ^ 2047);
        case 464:
            return a3 & (a1 ^ (a2 | a0 ^ a1));
        case 465:
            return a1 ^ (a2 | a0 ^ a1);
        case 466:
            return a0 ^ a2 & ~(a3 & (a0 ^ a1));
        case 467:
            return a1 & a2 ^ (a0 | a2 & a3);
        case 468:
            return a0 ^ a2 ^ a2 & (a1 ^ a0 & a3);
        case 469:
            return a1 ^ (a2 & a3 | a0 ^ a1);
        case 470:
            return a0 ^ a2 & (a0 ^ a1 ^ a3);
        case 471:
            return (a0 | a2) ^ a1 & a2 & a3;
        case 472:
            return a1 ^ 2047 ^ a0 & (a2 ^ (a1 | a2 & a3));
        case 473:
            return ~(a1 & a2) & (a0 | a1 ^ a3);
        case 474:
            return a1 ^ a3 ^ a0 & a1 & (a2 ^ a3);
        case 475:
            return 2047 ^ a1 & (a3 ^ a0 & (a2 ^ a3));
        case 476:
            return a3 ^ a1 & (a3 ^ a0 & (a2 ^ a3));
        case 477:
            return a1 ^ 2047 | a0 & (a2 ^ a3);
        case 478:
            return a1 ^ a3 | a2 ^ (a0 | a1 & a2);
        case 479:
            return a1 ^ a3 | a0 & (a2 ^ a3);
        case 480:
            return a3 & (a1 ^ a2);
        case 481:
            return a1 ^ a2;
        case 482:
            return a0 ^ a2 ^ a3 & (a0 ^ a1);
        case 483:
            return a1 ^ a2 & (a0 | a3);
        case 484:
            return a0 ^ a1 ^ a2 ^ a0 & a3;
        case 485:
            return a0 ^ a3 & (a0 ^ a1 ^ a2);
        case 486:
            return a1 ^ a2 & a3;
        case 487:
            return a2 ^ a1 & a3;
        case 488:
            return a2 ^ (a1 | a3 ^ (a0 | a2 & a3));
        case 489:
            return a1 ^ a3 ^ (a2 ^ a3) & (a0 | a1);
        case 490:
            return a1 ^ (a2 & a3 | (a1 ^ a3) & (a0 ^ a3));
        case 491:
            return a1 ^ a2 | a0 ^ (a0 | a1 ^ a3);
        case 492:
            return a1 ^ a3 ^ (a0 | a1) & (a2 ^ (a0 | a3));
        case 493:
            return a1 ^ a2 | a3 ^ (a0 | a1 & a3);
        case 494:
            return a1 ^ 2047 ^ (a2 ^ a3) & (a0 | a1);
        case 495:
            return a1 ^ a2 & a3 | a3 ^ (a0 | a1);
        case 496:
            return a2 ^ (a1 | a0 & (a2 ^ a3));
        case 497:
            return a2 ^ (a1 | a2 ^ (a0 | a2 & a3));
        case 498:
            return a1 ^ (a2 & a3 | a0 & (a1 ^ a3));
        case 499:
            return a1 ^ a2 | a2 ^ (a0 | a1 & a3);
        case 500:
            return (a0 | a1 ^ a2) & (a3 ^ a1 & a2);
        case 501:
            return a1 ^ a2 | a0 & (a2 ^ a3);
        case 502:
            return a1 ^ a2 & a3 | a2 ^ (a0 | a1);
        case 503:
            return a1 ^ (a2 & a3 | a0 ^ a0 & a1);
        case 504:
            return a2 ^ (a1 | a2 ^ a3);
        case 505:
            return 2047 ^ a1 & a2;
        case 506:
            return a0 ^ 2047 ^ a3 & (a0 ^ a1 & a2);
        case 507:
            return (a0 | a3) ^ a1 & a2;
        case 508:
            return a1 & a2 ^ (a3 | a0 ^ a2);
        case 509:
            return (a0 | a3) ^ a1 & a2 & a3;
        case 510:
            return a3 ^ a1 & a2;
        case 511:
            return 2047 ^ a1 & a2 & a3;
        case 512:
            return a2 & (a2 ^ (a0 | a1 ^ a3));
        case 513:
            return a2 & (a0 ^ a1) & (a0 ^ a3);
        case 514:
            return a0 ^ (a0 | a1 & a2);
        case 515:
            return a0 ^ (a1 & a2 | a0 ^ a3 ^ 2047);
        case 516:
            return a1 & a2 & (a0 ^ a3);
        case 517:
            return a2 & (a3 ^ (a0 | ~a1));
        case 518:
            return a0 ^ 2047 ^ (a0 ^ a3) & (a3 ^ a1 & a2);
        case 519:
            return a2 & (a3 ^ (a0 | a1 ^ a3));
        case 520:
            return a3 & (2047 ^ (a0 | a1 ^ a2));
        case 521:
            return a3 ^ (a1 ^ a2 | a0 & a3);
        case 522:
            return 2047 ^ (a0 | a3 & (a1 ^ a2));
        case 523:
            return a0 ^ (a0 & a3 | a1 ^ a2 ^ 2047);
        case 524:
            return a0 ^ (a0 & a3 | a1 ^ a2 ^ a3);
        case 525:
            return a3 ^ (a0 | a3 & (a1 ^ a2));
        case 526:
            return 2047 ^ (a1 ^ a2 | a0 & a3);
        case 527:
            return a3 ^ (a0 | a2 ^ a1 & a3);
        case 528:
            return a3 & (a0 ^ a2) & (a0 ^ a1);
        case 529:
            return (a1 ^ a2 ^ a3) & (a2 ^ a0 & a3);
        case 530:
            return (a1 | a2) ^ (a0 | a3 & (a1 ^ a2));
        case 531:
            return (a0 ^ a1) & (a2 ^ a0 & a3);
        case 532:
            return a3 ^ 2047 ^ (a0 ^ a1) & (a2 ^ a0 & a3);
        case 533:
            return (a0 ^ a1 & a3) & (a0 ^ a2 & a3);
        case 534:
            return (a1 | a2) ^ (a1 ^ a2 | a0 & a3);
        case 535:
            return (a1 | a2) ^ a3 & (a0 | a1 ^ a2);
        case 536:
            return a2 ^ (a0 & a2 | a1 ^ a3);
        case 537:
            return (a1 ^ a2 ^ a3) & (a3 ^ a0 & a2);
        case 538:
            return a1 ^ (a0 & a1 | a2 ^ 2047);
        case 539:
            return a1 ^ (a0 & a1 | a2 ^ (a1 | a3));
        case 540:
            return a2 ^ 2047 ^ a1 & (a3 ^ a0 & a2);
        case 541:
            return a3 ^ (a0 & a1 | a1 ^ a2);
        case 542:
            return a1 ^ a2 ^ (a0 ^ a1 | a3 ^ a1 & a2);
        case 543:
            return a3 ^ (a0 & a2 | a1 ^ a2 & a3);
        case 544:
            return a0 ^ (a0 | a1 & a3);
        case 545:
            return a1 ^ (a0 & a1 | a3 ^ 2047);
        case 546:
            return a0 ^ (a0 | a1 | a3 ^ 2047);
        case 547:
            return a0 ^ (a1 | a0 & a3);
        case 548:
            return a0 ^ a3 ^ 2047 ^ (a1 | a0 & a3);
        case 549:
            return a0 ^ a3 & (a0 | a1);
        case 550:
            return a1 & ~(a0 & a3);
        case 551:
            return a3 ^ (a0 | 2047 ^ a1 & a3);
        case 552:
            return 2047 ^ (a0 | a2 & (a1 ^ a3));
        case 553:
            return (a1 | a3) ^ (a0 | a2 & (a1 ^ a3));
        case 554:
            return a0 ^ (a0 | a1 | a2 ^ 2047);
        case 555:
            return a0 ^ (a1 | a0 ^ a3 ^ (a0 | a2));
        case 556:
            return (a0 ^ a3) & (a1 | a2 ^ 2047);
        case 557:
            return a3 ^ (a0 | a1 ^ (a1 | a2));
        case 558:
            return a0 ^ 2047 ^ a2 & (a1 ^ a3) & (a0 ^ a3);
        case 559:
            return a3 ^ (a0 | a2 & (a1 ^ a3));
        case 560:
            return a0 ^ (a0 & a2 | a1 ^ a3 ^ 2047);
        case 561:
            return (a0 ^ a1) & (a3 ^ a0 & a2);
        case 562:
            return a0 ^ (a1 | a0 & a2);
        case 563:
            return a0 ^ (a1 | a2 ^ a2 & (a0 ^ a3));
        case 564:
            return a0 ^ (a1 & a3 | a0 & (a1 ^ a2));
        case 565:
            return a0 ^ a3 ^ 2047 ^ (a1 | a0 & a2);
        case 566:
            return a0 ^ 2047 ^ (a1 ^ a3) & (a3 ^ a0 & a2);
        case 567:
            return a0 & a3 ^ (a1 | a0 & a2);
        case 568:
            return a0 ^ (a1 & a3 | a0 ^ a2 ^ 2047);
        case 569:
            return a1 ^ (a0 & a1 | a3 ^ (a1 | a2));
        case 570:
            return a0 ^ (a1 | a0 ^ a2 ^ (a0 | a3));
        case 571:
            return a0 ^ (a1 | a2 ^ 2047 ^ a0 & a3);
        case 572:
            return a0 ^ a1 ^ a3 ^ (a1 | a2 ^ a0 & a3);
        case 573:
            return a0 ^ a3 & (a1 | a0 ^ a2 ^ a3);
        case 574:
            return a2 ^ 2047 ^ a1 & (a2 ^ a0 & a3);
        case 575:
            return a0 ^ (a1 & a3 | a0 ^ a2 ^ a3);
        case 576:
            return a1 & a3 & (a0 ^ a2);
        case 577:
            return a2 ^ (a0 & a1 | a2 & (a1 ^ a3));
        case 578:
            return (a0 ^ a2) & (a1 | a3 ^ 2047);
        case 579:
            return a0 ^ (a1 & a2 | a0 & (a1 ^ a3));
        case 580:
            return a0 ^ a1 ^ a2 ^ a3 & (a1 | a0 ^ a2);
        case 581:
            return a0 ^ a3 & (a0 ^ a1 & (a0 ^ a2));
        case 582:
            return a1 & (a2 ^ a0 & a3);
        case 583:
            return a3 ^ 2047 | a1 & (a0 ^ a2);
        case 584:
            return a0 ^ (a0 & a2 | a1 ^ a2 ^ a3);
        case 585:
            return a2 ^ 2047 ^ (a0 ^ a1) & (a3 ^ a0 & a2);
        case 586:
            return a0 ^ a2 ^ 2047 ^ (a1 | a0 & a2);
        case 587:
            return a0 ^ a1 ^ a2 ^ (a1 | a3 ^ a0 & a2);
        case 588:
            return a0 ^ a1 ^ a3 ^ a2 & (a1 | a0 ^ a3);
        case 589:
            return a0 ^ a2 ^ a3 ^ (a1 | a0 & a2);
        case 590:
            return a0 ^ a2 ^ (a1 ^ a3) & (a3 ^ a0 & a2);
        case 591:
            return a0 ^ a1 ^ (a2 ^ 2047 | a0 & (a1 ^ a3));
        case 592:
            return a2 ^ (a0 | a2 & (a1 ^ a3));
        case 593:
            return (a0 ^ a2 & a3) & (a0 ^ a1 & a2);
        case 594:
            return a0 ^ a2 & (a0 | a1);
        case 595:
            return a0 ^ a2 & (a1 | a0 ^ a2 ^ a3);
        case 596:
            return a0 ^ a2 & (a0 ^ a1 & (a0 ^ a3));
        case 597:
            return a0 ^ a2 ^ a2 & (a3 ^ (a0 | a1));
        case 598:
            return a0 ^ a2 & (a2 ^ (a1 ^ a3) & (a0 ^ a3));
        case 599:
            return (a0 | a1) & (a2 ^ a0 & a3);
        case 600:
            return a2 ^ (a0 | 2047 ^ a1 & a3);
        case 601:
            return a2 ^ (a0 & a1 | a1 ^ a3);
        case 602:
            return a2 ^ (a0 | a1 ^ (a1 | a3));
        case 603:
            return a0 ^ a2 ^ 2047 ^ (a1 | a0 & a3);
        case 604:
            return a0 ^ a2 ^ a3 ^ (a1 | a0 & a3);
        case 605:
            return a0 ^ a2 ^ 2047 ^ a3 & (a0 | a1);
        case 606:
            return a2 ^ (a1 ^ 2047 | a0 & a3);
        case 607:
            return a2 ^ a3 & (a0 | a1 ^ a3);
        case 608:
            return 2047 ^ (a0 & a2 | a1 ^ a3);
        case 609:
            return (a1 | a3) ^ (a0 & a2 | a1 ^ a3);
        case 610:
            return a1 & (2047 ^ a0 & a2);
        case 611:
            return a2 ^ (a0 & a1 | a3 & (a1 ^ a2));
        case 612:
            return a1 & (a3 ^ a0 & a2);
        case 613:
            return a3 ^ (a0 & a2 | a1 ^ 2047);
        case 614:
            return a0 ^ (a0 ^ a1 | a2 ^ a2 & (a0 ^ a3));
        case 615:
            return a3 ^ (a0 & a2 | a1 ^ a3);
        case 616:
            return a0 ^ 2047 ^ (a0 ^ a2) & (a2 ^ a1 & a3);
        case 617:
            return a1 ^ a3 ^ (a0 ^ a2 | a0 ^ a1 & a3);
        case 618:
            return a0 ^ 2047 ^ a3 & (a0 ^ a2) & (a1 ^ a2);
        case 619:
            return a0 ^ 2047 ^ (a1 ^ a2) & (a2 ^ a0 & a3);
        case 620:
            return a0 ^ a3 ^ (a1 ^ a2) & (a2 ^ a0 & a3);
        case 621:
            return a0 ^ a3 & (a0 ^ a1 | a1 ^ a2 ^ a3);
        case 622:
            return a0 ^ (a0 ^ a1 | a2 ^ 2047 ^ a0 & a3);
        case 623:
            return a3 ^ (a0 | a2) | a1 & (a0 ^ a2);
        case 624:
            return a2 ^ (a0 | a2 ^ a1 & a3);
        case 625:
            return a2 ^ (a0 & a3 | a1 ^ a2 & a3);
        case 626:
            return a2 ^ (a0 | a3 & (a1 ^ a2));
        case 627:
            return a0 & a2 ^ (a1 | a0 & a3);
        case 628:
            return a0 ^ a1 ^ (a3 ^ 2047 | a0 & (a1 ^ a2));
        case 629:
            return a0 & a2 ^ a3 & (a0 | a1);
        case 630:
            return a2 ^ (a1 ^ a2 | a0 & a3);
        case 631:
            return a2 ^ a3 & (a0 | a1 ^ a2);
        case 632:
            return a2 ^ (a0 | a3 ^ a1 & a2);
        case 633:
            return (a1 | a3) ^ a2 & (a0 | a1 ^ a3);
        case 634:
            return a2 ^ (a0 | 2047 ^ a1 & a2);
        case 635:
            return a0 ^ (a1 & a2 | a0 ^ a2 ^ a3);
        case 636:
            return a2 ^ 2047 | a1 & (a0 ^ a3);
        case 637:
            return a3 ^ a2 & (a0 | a1 ^ a2);
        case 638:
            return a2 ^ (a0 | a3) | a1 & (a0 ^ a3);
        case 639:
            return a3 ^ a2 & (a0 | a1 ^ a3);
        case 640:
            return a0 ^ (a0 | a2 & a3);
        case 641:
            return (a1 | a3) ^ (a0 | a2 ^ a3);
        case 642:
            return a0 ^ (a0 | a2);
        case 643:
            return a2 & (a0 ^ (a1 | a3));
        case 644:
            return a2 & (a0 ^ (a3 | ~a1));
        case 645:
            return a2 & (a0 ^ a3);
        case 646:
            return a2 & (a0 ^ (a3 | a0 ^ a1));
        case 647:
            return a2 & ~(a0 & a3);
        case 648:
            return 2047 ^ (a0 | a1 & (a2 ^ a3));
        case 649:
            return (a1 | a3) ^ (a0 | a1 & (a2 ^ a3));
        case 650:
            return a0 ^ (a0 | a3 ^ a1 & (a2 ^ a3));
        case 651:
            return a0 ^ (a2 & a3 | a0 ^ a2 | a1 ^ a3);
        case 652:
            return (a0 ^ a3) & (a0 ^ a2 | a1 ^ a3);
        case 653:
            return a3 ^ (a0 | a2 ^ (a1 | a2 & a3));
        case 654:
            return a0 ^ 2047 ^ a1 & (a3 ^ (a0 | a2 & a3));
        case 655:
            return a3 ^ (a0 | a1 & (a2 ^ a3));
        case 656:
            return (a1 | a2) ^ (a0 | a1 & (a2 ^ a3));
        case 657:
            return a0 ^ (a2 & a3 | a0 & a1);
        case 658:
            return (a0 ^ a2) & (a0 ^ (a1 | a0 ^ a3));
        case 659:
            return a2 ^ a0 & (a3 ^ a1 & (a2 ^ a3));
        case 660:
            return a0 ^ (a2 & a3 | a0 & (a1 ^ a2));
        case 661:
            return a0 ^ (a2 & a3 | (a0 ^ a2) & (a1 ^ a2));
        case 662:
            return a0 ^ a2 ^ a0 & a1 & (a2 ^ a3);
        case 663:
            return a0 ^ (a2 & a3 | a1 & (a0 ^ a2));
        case 664:
            return (a1 | a2) ^ (a0 | a2 ^ a3);
        case 665:
            return a0 ^ 2047 ^ (a2 ^ a3) & (a0 ^ a1);
        case 666:
            return a0 ^ (a2 | a0 ^ a1 ^ a3);
        case 667:
            return a1 ^ a3 ^ a2 & (a0 ^ a1 & a3);
        case 668:
            return a1 ^ 2047 ^ a2 & (a0 ^ a1 & a3);
        case 669:
            return a1 ^ a3 ^ a2 & (a0 ^ a1);
        case 670:
            return a0 ^ a3 ^ (a2 ^ a3) & (a0 ^ a1);
        case 671:
            return a1 ^ 2047 ^ a2 & (a1 ^ a0 & a3);
        case 672:
            return a0 ^ (a0 | a2 ^ a1 & (a2 ^ a3));
        case 673:
            return (a1 | a2) & (a0 ^ (a3 | a0 & a1));
        case 674:
            return a0 ^ (a0 | a1 | a2 & a3);
        case 675:
            return a0 ^ (a1 | a2 ^ a0 & (a2 ^ a3));
        case 676:
            return (a0 ^ a3) & (a1 | a0 ^ a2);
        case 677:
            return a0 ^ a2 ^ (a2 ^ a3) & (a0 | a1);
        case 678:
            return ~(a0 & a3) & (a1 | a0 ^ a2);
        case 679:
            return a3 ^ (a0 | a3 ^ (a1 | a2 & a3));
        case 680:
            return a0 ^ (a0 | a3);
        case 681:
            return a0 ^ (a3 | a0 ^ a1 ^ 2047);
        case 682:
            return a0 ^ 2047;
        case 683:
            return a0 ^ (a1 | a3);
        case 684:
            return a0 ^ (a3 | a1 ^ 2047);
        case 685:
            return a0 ^ a3;
        case 686:
            return a0 ^ (a3 | a0 ^ a1);
        case 687:
            return 2047 ^ a0 & a3;
        case 688:
            return a3 & (a0 ^ (a1 | a2));
        case 689:
            return a1 ^ a2 ^ a3 & (a0 ^ a1 & a2);
        case 690:
            return a0 ^ (a1 | a2);
        case 691:
            return a0 ^ (a1 | a2 & a3);
        case 692:
            return a0 ^ a2 ^ a1 & (a2 ^ a3);
        case 693:
            return a0 ^ a3 & (a1 | a2);
        case 694:
            return a0 & a3 ^ (a1 | a2 & a3);
        case 695:
            return (a1 | a2) ^ a0 & a3;
        case 696:
            return a0 ^ (a2 & a3 | a1 ^ a2 | a0 ^ a3);
        case 697:
            return a3 ^ a0 & (a2 ^ a1 & (a2 ^ a3));
        case 698:
            return a0 ^ (a1 | a3 ^ a0 & (a2 ^ a3));
        case 699:
            return 2047 ^ a0 & (a1 | a2 & a3);
        case 700:
            return a3 ^ a0 & (a1 | a2 & a3);
        case 701:
            return a0 ^ a3 | 2047 ^ (a1 | a0 & a2);
        case 702:
            return 2047 ^ a0 & (a2 ^ a1 & (a2 ^ a3));
        case 703:
            return a0 ^ a3 | (a2 ^ a3) & (a0 ^ a1);
        case 704:
            return (a0 ^ a2) & (a2 ^ a1 & (a2 ^ a3));
        case 705:
            return a0 ^ (a2 & a3 | a0 & (a1 ^ a3));
        case 706:
            return (a0 ^ a2) & (a1 | a0 ^ a3);
        case 707:
            return a2 ^ a0 & (a1 | a2 & a3);
        case 708:
            return a0 ^ (a2 & a3 | a0 ^ a0 & a1);
        case 709:
            return a0 ^ a2 ^ (a0 | a1) & (a3 ^ (a1 | a2));
        case 710:
            return a2 ^ a0 & (a2 ^ a1 & (a2 ^ a3));
        case 711:
            return (a1 | a0 ^ a3) & (a2 ^ a0 & a3);
        case 712:
            return a3 & (a0 ^ (a2 | a1 ^ 2047));
        case 713:
            return a1 ^ 2047 ^ a3 & (a0 ^ a1 & a2);
        case 714:
            return a0 ^ (a2 | a1 ^ 2047);
        case 715:
            return a0 ^ a3 ^ a1 & (a2 ^ a3);
        case 716:
            return a0 ^ 2047 ^ a1 & (a2 ^ a3);
        case 717:
            return a0 ^ a1 ^ a3 ^ a1 & a2;
        case 718:
            return a0 ^ (a2 & a3 | a1 ^ (a0 | a3));
        case 719:
            return a0 & a3 ^ (a2 | a1 ^ 2047);
        case 720:
            return a3 & (a0 ^ a2);
        case 721:
            return a1 ^ a2 ^ a3 & (a0 ^ a1);
        case 722:
            return a0 ^ a2;
        case 723:
            return a0 ^ a2 & (a1 | a3);
        case 724:
            return a0 ^ a1 ^ a2 ^ a1 & a3;
        case 725:
            return a0 ^ a2 & a3;
        case 726:
            return a0 ^ a2 & (a3 | a0 ^ a1);
        case 727:
            return a2 ^ a0 & a3;
        case 728:
            return a2 ^ (a0 | a3 ^ (a1 | a2 & a3));
        case 729:
            return a0 ^ (a2 & a3 | (a1 ^ a3) & (a0 ^ a3));
        case 730:
            return a0 ^ a3 ^ (a2 ^ a3) & (a0 | a1);
        case 731:
            return a0 ^ a2 | a1 ^ (a1 | a0 ^ a3);
        case 732:
            return a0 ^ a3 ^ (a0 | a1) & (a2 ^ (a1 | a3));
        case 733:
            return a0 ^ 2047 ^ (a2 ^ a3) & (a0 | a1);
        case 734:
            return a0 ^ a2 | (a1 ^ a3) & (a0 ^ a3);
        case 735:
            return a0 ^ a2 & a3 | a3 ^ (a0 | a1);
        case 736:
            return a3 & (a0 ^ (a2 | a0 ^ a1));
        case 737:
            return a0 ^ a2 ^ (a2 ^ a3) & (a0 ^ a1);
        case 738:
            return a0 ^ (a2 | a0 ^ a1);
        case 739:
            return a0 & a2 ^ (a1 | a2 & a3);
        case 740:
            return a0 ^ (a2 & a3 | a1 ^ (a0 | a2));
        case 741:
            return a0 ^ a3 & (a2 | a0 ^ a1);
        case 742:
            return a0 ^ (a2 & a3 | a0 ^ a1);
        case 743:
            return (a1 | a2) ^ a0 & a2 & a3;
        case 744:
            return a0 ^ 2047 ^ a1 & (a2 ^ (a0 | a2 & a3));
        case 745:
            return a0 ^ a3 ^ a0 & a1 & (a2 ^ a3);
        case 746:
            return (a1 | a0 ^ a3) & (2047 ^ a0 & a2);
        case 747:
            return 2047 ^ a0 & (a3 ^ a1 & (a2 ^ a3));
        case 748:
            return a3 ^ a0 & (a3 ^ a1 & (a2 ^ a3));
        case 749:
            return a0 ^ a3 | a2 ^ (a1 | a2 & a3);
        case 750:
            return a0 ^ 2047 | a1 & (a2 ^ a3);
        case 751:
            return a0 ^ a3 | a1 & (a0 ^ a2);
        case 752:
            return a2 ^ (a0 | a1 & (a2 ^ a3));
        case 753:
            return a0 ^ (a2 & a3 | a1 & (a0 ^ a3));
        case 754:
            return a2 ^ (a0 | a2 ^ (a1 | a2 & a3));
        case 755:
            return a0 ^ a2 | (a2 ^ a3) & (a0 ^ a1);
        case 756:
            return (a1 | a0 ^ a2) & (a3 ^ a0 & a2);
        case 757:
            return a0 ^ a2 & a3 | a2 ^ (a0 | a1);
        case 758:
            return a0 ^ a2 | a1 & (a2 ^ a3);
        case 759:
            return a0 ^ (a2 & a3 | a0 ^ (a0 | a1));
        case 760:
            return a2 ^ (a0 | a2 ^ a3);
        case 761:
            return a1 ^ 2047 ^ a3 & (a1 ^ a0 & a2);
        case 762:
            return 2047 ^ a0 & a2;
        case 763:
            return a0 & a2 ^ (a1 | a3);
        case 764:
            return a0 & a2 ^ (a3 | a1 ^ 2047);
        case 765:
            return a3 ^ a0 & a2;
        case 766:
            return a0 & a2 ^ (a3 | a0 ^ a1);
        case 767:
            return 2047 ^ a0 & a2 & a3;
        case 768:
            return a2 & a3 & (a0 ^ a1);
        case 769:
            return a2 & (a1 ^ (a0 | a3 ^ 2047));
        case 770:
            return a2 & (a0 ^ (a1 | ~a3));
        case 771:
            return a2 & (a0 ^ a1);
        case 772:
            return a2 & (a0 ^ a1 ^ a3 ^ 2047);
        case 773:
            return a2 & (a0 ^ a1 & a3);
        case 774:
            return a2 & (a1 ^ a0 & a3);
        case 775:
            return a2 & (a2 ^ a3 | a0 ^ a1);
        case 776:
            return a0 ^ (a0 & a1 | a1 ^ a2 ^ a3);
        case 777:
            return a0 ^ (a0 & a1 | a2 ^ 2047 ^ a1 & a3);
        case 778:
            return a0 ^ (a0 & (a2 ^ a3) | a1 ^ a2 ^ 2047);
        case 779:
            return a0 ^ (a1 & a2 | a2 ^ (a0 | a1 ^ a3));
        case 780:
            return a3 ^ (a0 & a1 | a3 & (a0 ^ a1 ^ a2));
        case 781:
            return a0 ^ a2 ^ (a1 ^ a3 | a0 & (a2 ^ a3));
        case 782:
            return a0 ^ (a1 ^ a2 ^ a3 | a1 & (a0 ^ a2));
        case 783:
            return a0 ^ a1 ^ a3 ^ (a2 & a3 | a0 & a1);
        case 784:
            return a0 ^ (a0 & a1 | a2 & (a1 ^ a3 ^ 2047));
        case 785:
            return a0 ^ a1 & (a0 | a2 & a3);
        case 786:
            return a0 & a1 ^ (a1 & a2 | a0 & a3);
        case 787:
            return a1 ^ (a0 | a2 ^ (a1 | a2 & a3));
        case 788:
            return a0 & a1 ^ a3 & (a0 | a1 & a2);
        case 789:
            return a1 & a3 ^ (a0 | a2 ^ (a1 | a2 & a3));
        case 790:
            return a0 ^ a3 ^ 2047 ^ a1 & (a0 | a2 & a3);
        case 791:
            return a0 ^ a1 & (a2 ^ a0 & (a2 ^ a3));
        case 792:
            return a3 & (a1 ^ (a0 | a2 ^ 2047));
        case 793:
            return a1 ^ (a0 | a2 ^ a3);
        case 794:
            return a0 ^ a1 ^ (a1 | a3) ^ (a0 | a2);
        case 795:
            return a1 ^ (a0 | a2 ^ 2047);
        case 796:
            return a0 ^ a1 ^ a3 ^ (a0 | a2);
        case 797:
            return a1 & a3 ^ (a0 | a2 ^ 2047);
        case 798:
            return a1 ^ a3 & (a0 | a2 ^ a3);
        case 799:
            return a1 & a3 ^ (a0 | a2 ^ a3);
        case 800:
            return a0 ^ (a0 & (a2 ^ a3) | a1 ^ a3 ^ 2047);
        case 801:
            return (a1 | a2) & (a0 ^ a1 & (a0 | a3));
        case 802:
            return a0 ^ (a1 | a0 & (a2 ^ a3));
        case 803:
            return a0 ^ (a1 | a2 ^ (a0 | a2 & a3));
        case 804:
            return a0 & a1 ^ a3 & (a1 | a0 & a2);
        case 805:
            return a0 ^ a3 ^ 2047 ^ (a1 | a0 & (a2 ^ a3));
        case 806:
            return a0 & a3 ^ (a1 | a2 ^ (a0 | a2 & a3));
        case 807:
            return a1 ^ a0 & (a2 ^ a1 & (a2 ^ a3));
        case 808:
            return a3 & (a0 ^ (a1 | ~a2));
        case 809:
            return a0 ^ a1 ^ (a1 | a2) ^ (a0 | a3);
        case 810:
            return a0 ^ (a1 | a2 ^ a3);
        case 811:
            return a0 ^ (a1 | a2 ^ 2047);
        case 812:
            return a0 ^ a1 ^ a3 ^ (a1 | a2);
        case 813:
            return a0 ^ a3 & (a1 | a2 ^ 2047);
        case 814:
            return a0 & a3 ^ (a1 | a2 ^ 2047);
        case 815:
            return a0 & a3 ^ (a1 | a2 ^ a3);
        case 816:
            return a3 & (a0 ^ a1);
        case 817:
            return a1 ^ (a0 | a3 ^ 2047);
        case 818:
            return a0 ^ (a1 | a3 ^ 2047);
        case 819:
            return a0 ^ a1;
        case 820:
            return a0 ^ a1 ^ a3 ^ 2047;
        case 821:
            return a0 ^ a1 & a3;
        case 822:
            return a1 ^ a0 & a3;
        case 823:
            return a0 ^ a1 | a3 ^ 2047;
        case 824:
            return a0 ^ (a1 & a3 | a3 ^ (a0 | a1 ^ a2));
        case 825:
            return a1 ^ (a0 | a3 ^ (a1 | a2 & a3));
        case 826:
            return a0 ^ (a1 | a3 ^ (a0 | a2 & a3));
        case 827:
            return a0 ^ (a1 | a0 ^ (a0 | a2 ^ a3));
        case 828:
            return a0 ^ a1 ^ a3 ^ (a0 | a1 | a2 & a3);
        case 829:
            return a1 ^ 2047 ^ (a0 ^ a3) & (a1 | a0 ^ a2);
        case 830:
            return a0 ^ 2047 ^ (a1 ^ a3) & (a0 | a2 & a3);
        case 831:
            return a0 ^ a1 | a3 ^ (a0 | a2 & a3);
        case 832:
            return a2 ^ (a0 & a1 | a2 & (a3 ^ (a0 | a1)));
        case 833:
            return a0 & a1 ^ a2 & (a0 | a1 & a3);
        case 834:
            return a0 & a1 ^ a2 & (a1 | a0 & a3);
        case 835:
            return a0 ^ a1 ^ a2 ^ (a0 | a1 | a2 & a3);
        case 836:
            return a0 ^ a1 ^ (a2 ^ a3) & (a0 | a1);
        case 837:
            return a0 ^ a1 ^ (a2 ^ a3) & (a1 | a0 ^ a2);
        case 838:
            return a0 ^ a1 ^ (a2 ^ a3) & (a0 | a1 ^ a2);
        case 839:
            return (a0 | a1) & (a2 ^ a0 & a1 & a3);
        case 840:
            return a2 ^ 2047 ^ a3 & (a0 ^ a1);
        case 841:
            return a0 ^ a1 ^ a2 ^ (a0 | a3);
        case 842:
            return a0 ^ a1 ^ a2 ^ (a1 | a3);
        case 843:
            return a0 ^ a1 ^ a2 ^ 2047;
        case 844:
            return a0 ^ a1 ^ a2 ^ a3;
        case 845:
            return a0 ^ a2 ^ 2047 ^ a1 & a3;
        case 846:
            return a1 ^ a2 ^ 2047 ^ a0 & a3;
        case 847:
            return a2 ^ a3 & (a0 ^ a1 ^ a3);
        case 848:
            return a3 & (a0 ^ a1 & a2);
        case 849:
            return a1 & a2 ^ (a0 | a3 ^ 2047);
        case 850:
            return a0 ^ a2 & (a1 | a3 ^ 2047);
        case 851:
            return a0 ^ a1 & a2;
        case 852:
            return a0 ^ a2 & (a1 ^ a3 ^ 2047);
        case 853:
            return a0 ^ a1 & a2 & a3;
        case 854:
            return a1 & a2 ^ a0 & a3;
        case 855:
            return a3 ^ 2047 | a0 ^ a1 & a2;
        case 856:
            return a0 ^ a3 ^ (a1 ^ a2 | a0 & (a2 ^ a3));
        case 857:
            return a1 & a2 ^ (a0 | a3 ^ (a1 | a2 & a3));
        case 858:
            return a0 ^ a2 ^ 2047 ^ (a1 | a0 & (a2 ^ a3));
        case 859:
            return a1 ^ 2047 ^ (a0 ^ a2) & (a1 | a0 ^ a3);
        case 860:
            return a0 ^ a1 ^ (a2 ^ a3) & (a1 | a0 ^ a3);
        case 861:
            return a0 ^ a1 ^ (a2 ^ a3) & (a1 | ~a0);
        case 862:
            return a0 ^ a1 ^ (a2 ^ a3) & (a1 ^ a2 | a0 ^ a3);
        case 863:
            return a0 ^ 2047 ^ (a1 ^ a2 | a0 & (a2 ^ a3));
        case 864:
            return a3 & (a1 ^ a0 & a2);
        case 865:
            return a1 ^ a2 & (a0 | a2 ^ a3);
        case 866:
            return a0 & a2 ^ (a1 | a3 ^ 2047);
        case 867:
            return a1 ^ a0 & a2;
        case 868:
            return a1 ^ a2 ^ a2 & (a0 ^ a3);
        case 869:
            return a0 & a2 ^ a1 & a3;
        case 870:
            return a1 ^ a0 & a2 & a3;
        case 871:
            return a3 ^ 2047 | a1 ^ a0 & a2;
        case 872:
            return a0 ^ (a1 ^ a2 ^ a3 | a1 & (a0 ^ a3));
        case 873:
            return a0 ^ a2 ^ 2047 ^ a1 & (a0 | a2 & a3);
        case 874:
            return a0 & a2 ^ (a1 | a3 ^ (a0 | a2 & a3));
        case 875:
            return a0 ^ 2047 ^ (a1 ^ a2) & (a0 | a2 & a3);
        case 876:
            return a0 ^ a1 ^ (a2 ^ a3) & (a0 | a1 ^ a3);
        case 877:
            return a0 ^ a1 ^ (a2 ^ a3) & (a0 ^ a2 | a1 ^ a3);
        case 878:
            return a0 ^ a1 ^ (a2 ^ a3) & (a0 | a1 ^ 2047);
        case 879:
            return a1 ^ 2047 ^ (a0 ^ a2 | a1 & (a2 ^ a3));
        case 880:
            return a0 ^ a1 ^ a2 ^ (a2 & a3 | a0 & a1);
        case 881:
            return a0 ^ a1 & (a3 ^ a0 & (a2 ^ a3));
        case 882:
            return a1 ^ a0 & (a3 ^ a1 & (a2 ^ a3));
        case 883:
            return a0 ^ a1 | a2 ^ (a1 | a2 & a3);
        case 884:
            return (a0 | a1) & (a3 ^ a0 & a1 & a2);
        case 885:
            return a0 ^ 2047 ^ (a1 ^ a3 | a0 & (a2 ^ a3));
        case 886:
            return a1 ^ 2047 ^ (a0 ^ a3 | a1 & (a0 ^ a2));
        case 887:
            return a0 ^ a1 | a0 & (a2 ^ a3);
        case 888:
            return a3 & (a2 ^ a3 | a0 ^ a1);
        case 889:
            return a1 & a2 ^ (a0 | a2 ^ a3);
        case 890:
            return a0 & a2 ^ (a1 | a2 ^ a3);
        case 891:
            return a0 ^ a1 | a2 ^ 2047;
        case 892:
            return a2 ^ a3 ^ a2 & (a0 ^ a1);
        case 893:
            return a2 ^ 2047 | a0 ^ a1 & a3;
        case 894:
            return a2 ^ 2047 | a1 ^ a0 & a3;
        case 895:
            return a2 ^ a3 | a0 ^ a1;
        case 896:
            return a2 & ((a0 | a1 ^ a3) ^ (a1 | a2 ^ a3));
        case 897:
            return a2 & (a1 ^ (a0 | a1 ^ a3));
        case 898:
            return a2 & (a0 ^ (a1 | a0 ^ a3));
        case 899:
            return a2 & (a2 ^ a0 & a1);
        case 900:
            return a2 & (a3 ^ a0 & a1);
        case 901:
            return a2 & (a1 ^ 2047 | a0 ^ a3);
        case 902:
            return a2 & (a0 ^ a2 | a1 ^ a3);
        case 903:
            return a2 & (a0 ^ a1 | a1 ^ a3);
        case 904:
            return a2 ^ a3 ^ (a0 ^ a2 | a0 ^ a1 & a3);
        case 905:
            return a0 ^ 2047 ^ (a0 ^ a1) & (a2 ^ a1 & a3);
        case 906:
            return a0 ^ 2047 ^ a3 & (a0 ^ a1) & (a1 ^ a2);
        case 907:
            return a0 ^ (a1 ^ a2 ^ 2047 | a3 & (a0 ^ a2));
        case 908:
            return a0 ^ (a1 ^ a2 ^ a3 | a3 & (a0 ^ a2));
        case 909:
            return a0 ^ a3 ^ a3 & (a0 ^ a1) & (a1 ^ a2);
        case 910:
            return a0 ^ a3 ^ (a0 ^ a1) & (a2 ^ a1 & a3);
        case 911:
            return a0 ^ (a0 ^ a2 | a3 & (a0 ^ a1 ^ a3));
        case 912:
            return a3 & (a1 ^ (a0 | a1 ^ a2));
        case 913:
            return a1 ^ (a0 | a2 ^ a1 & a3);
        case 914:
            return a0 ^ a2 ^ a0 & a3 & (a1 ^ a2);
        case 915:
            return a1 ^ (a0 | a3 & (a1 ^ a2));
        case 916:
            return a0 ^ a1 ^ (a0 | a2) ^ a3 & (a0 | a1);
        case 917:
            return a0 ^ a3 & (a2 ^ a0 & (a1 ^ a2));
        case 918:
            return a1 ^ a3 & (a0 | a1 ^ a2);
        case 919:
            return a1 ^ (a1 ^ a2 | a0 & a3);
        case 920:
            return a0 ^ 2047 ^ (a0 ^ a1) & (a3 ^ a1 & a2);
        case 921:
            return a1 ^ (a0 | a3 ^ a1 & a2);
        case 922:
            return a0 ^ (a1 & a2 | a0 ^ a1 ^ a3);
        case 923:
            return a1 ^ (a0 | 2047 ^ a1 & a2);
        case 924:
            return a3 ^ a1 & (a0 | a1 ^ a2);
        case 925:
            return a1 ^ 2047 | a2 & (a0 ^ a3);
        case 926:
            return a1 ^ a3 | a0 ^ (a0 | a2);
        case 927:
            return a1 ^ a3 | a2 & (a0 ^ a1);
        case 928:
            return a3 & (a0 ^ (a1 | a0 ^ a2));
        case 929:
            return a0 ^ (a1 & a3 | a0 ^ a1 ^ a2);
        case 930:
            return a0 ^ (a1 | a2 ^ a0 & a3);
        case 931:
            return a0 ^ (a1 | a3 & (a0 ^ a2));
        case 932:
            return a0 ^ a1 ^ (a1 | a2) ^ a3 & (a0 | a1);
        case 933:
            return a0 ^ a3 & (a1 | a0 ^ a2);
        case 934:
            return a1 ^ a3 & (a2 ^ a1 & (a0 ^ a2));
        case 935:
            return a0 ^ (a0 ^ a2 | a1 & a3);
        case 936:
            return a0 ^ 2047 ^ a2 & (a0 ^ a1) & (a1 ^ a3);
        case 937:
            return a0 ^ a3 ^ a0 & a2 & (a1 ^ a3);
        case 938:
            return a0 ^ (a1 | a3 ^ a0 & a2);
        case 939:
            return a0 ^ (a1 | 2047 ^ a0 & a2);
        case 940:
            return a3 ^ a0 & (a1 | a0 ^ a2);
        case 941:
            return a0 ^ a3 | a1 ^ (a1 | a2);
        case 942:
            return a0 ^ 2047 | a2 & (a1 ^ a3);
        case 943:
            return a0 ^ a3 | a2 & (a0 ^ a1);
        case 944:
            return a0 ^ (a1 ^ a3 ^ 2047 | a2 & (a0 ^ a3));
        case 945:
            return a1 ^ (a0 | a2 & (a1 ^ a3));
        case 946:
            return a0 ^ (a1 | a2 & (a0 ^ a3));
        case 947:
            return a0 ^ (a1 | a0 ^ (a0 | a2));
        case 948:
            return a0 ^ a1 ^ a2 & (a3 ^ (a0 | a1));
        case 949:
            return a1 & a3 ^ (a0 | a1 ^ (a1 | a2));
        case 950:
            return a0 & a3 ^ (a1 | a0 ^ (a0 | a2));
        case 951:
            return a0 ^ a1 | a2 & (a1 ^ a3);
        case 952:
            return a3 & (2047 ^ a0 & a1);
        case 953:
            return a1 ^ (a0 | 2047 ^ a1 & a3);
        case 954:
            return a0 ^ (a1 | 2047 ^ a0 & a3);
        case 955:
            return a0 ^ (a1 | a0 ^ (a0 | a3));
        case 956:
            return a0 ^ a1 ^ 2047 ^ a3 & (a0 | a1);
        case 957:
            return a0 ^ a3 & (a1 | a0 ^ a3);
        case 958:
            return a1 ^ a3 & (a0 | a1 ^ a3);
        case 959:
            return 2047 ^ a0 & a1 & a3;
        case 960:
            return a3 & (a2 ^ a0 & a1);
        case 961:
            return a2 ^ a1 & (a0 | a1 ^ a3);
        case 962:
            return a2 ^ a0 & (a1 | a0 ^ a3);
        case 963:
            return a0 ^ a1 ^ a3 & (a2 ^ (a0 | a1));
        case 964:
            return a0 ^ a1 ^ a2 ^ a3 & (a0 | a1);
        case 965:
            return a0 ^ a3 & (a0 ^ a2 ^ a0 & a1);
        case 966:
            return a1 ^ a3 & (a2 ^ a1 & (a0 ^ a3));
        case 967:
            return a2 ^ a0 & a1 & a3;
        case 968:
            return a0 ^ (a1 ^ a2 ^ a3 | a2 & (a0 ^ a3));
        case 969:
            return a0 ^ a1 ^ (a0 | a3) ^ a2 & (a0 | a1);
        case 970:
            return a0 ^ a1 ^ (a1 | a3) ^ a2 & (a0 | a1);
        case 971:
            return a0 ^ a1 ^ 2047 ^ a2 & (a0 | a1);
        case 972:
            return a0 ^ a1 ^ a3 ^ a2 & (a0 | a1);
        case 973:
            return a0 ^ a2 ^ a3 ^ (a1 | a2 & (a0 ^ a3));
        case 974:
            return a0 ^ a2 ^ (a1 ^ a3) & (a0 | a2 ^ 2047);
        case 975:
            return a2 ^ 2047 ^ (a0 ^ a1 | a2 & (a1 ^ a3));
        case 976:
            return a0 ^ a2 & (a0 ^ a3 | a1 ^ a2 ^ a3);
        case 977:
            return a0 ^ a2 & (a3 ^ a0 & (a1 ^ a3));
        case 978:
            return a0 ^ a2 & (a1 | a0 ^ a3);
        case 979:
            return a0 ^ a2 & (a1 | a0 ^ a2);
        case 980:
            return a0 ^ a2 & (a3 ^ a0 & (a1 ^ a2));
        case 981:
            return a0 ^ a2 & a3 | a1 ^ (a1 | a2);
        case 982:
            return a0 ^ a2 | a2 & (a1 ^ a3);
        case 983:
            return a0 & a3 ^ a2 & (a1 | a0 ^ a3);
        case 984:
            return a3 & (a0 ^ a2 | a1 ^ a3);
        case 985:
            return a1 ^ 2047 | a3 & (a0 ^ a2);
        case 986:
            return a0 ^ a2 | a1 ^ (a1 | a3);
        case 987:
            return a1 & a2 ^ (a0 | a1 ^ (a1 | a3));
        case 988:
            return a0 ^ a2 ^ a3 ^ (a1 | a3 & (a0 ^ a2));
        case 989:
            return a0 ^ a2 & a3 | a1 ^ (a1 | a3);
        case 990:
            return a1 ^ a3 | a1 & (a0 ^ a2);
        case 991:
            return a0 ^ a2 | 2047 ^ a1 & a3;
        case 992:
            return a0 ^ a2 ^ (a0 ^ a1) & (a3 ^ a1 & a2);
        case 993:
            return a1 ^ a2 & (a0 | a1 ^ a3);
        case 994:
            return a1 ^ a2 & (a3 ^ a1 & (a0 ^ a3));
        case 995:
            return a1 ^ a2 & (a0 | a1 ^ a2);
        case 996:
            return a1 ^ a2 & (a0 ^ a3 ^ (a0 | a1));
        case 997:
            return a1 ^ a2 | a2 & (a0 ^ a3);
        case 998:
            return a1 ^ a2 & a3 | a0 ^ (a0 | a2);
        case 999:
            return a1 & a3 ^ a2 & (a0 | a1 ^ a3);
        case 1000:
            return a3 & (~a0 | a1 ^ a2);
        case 1001:
            return a1 ^ a2 | a0 ^ (a0 | a3);
        case 1002:
            return a0 ^ 2047 | a3 & (a1 ^ a2);
        case 1003:
            return a0 & a2 ^ (a1 | a0 ^ (a0 | a3));
        case 1004:
            return a0 ^ a3 ^ (a1 ^ a2) & (a0 | ~a3);
        case 1005:
            return a0 ^ a3 | a0 & (a1 ^ a2);
        case 1006:
            return a1 ^ a2 & a3 | a0 ^ (a0 | a3);
        case 1007:
            return a1 ^ a2 | 2047 ^ a0 & a3;
        case 1008:
            return a3 & (a0 ^ a2 | a0 ^ a1);
        case 1009:
            return a1 ^ a2 | a3 & (a0 ^ a1);
        case 1010:
            return a0 ^ a2 | a3 & (a0 ^ a1);
        case 1011:
            return a0 ^ a1 | a3 & (a1 ^ a2);
        case 1012:
            return a2 ^ (a0 | a1) & (a3 ^ a2 & (a0 ^ a1));
        case 1013:
            return a0 & a2 ^ a3 & (a1 | a0 ^ a2);
        case 1014:
            return a1 & a2 ^ a3 & (a0 | a1 ^ a2);
        case 1015:
            return a0 ^ a2 | a0 ^ a1 & a3;
        case 1016:
            return a0 ^ (a0 ^ a3 | a2 ^ a2 & (a0 ^ a1));
        case 1017:
            return a1 ^ (a0 & a2 | a1 ^ a3);
        case 1018:
            return a0 ^ (a1 & a2 | a0 ^ a3);
        case 1019:
            return 2047 ^ a0 & a1 & a2;
        case 1020:
            return a3 ^ a0 & a1 & a2;
        case 1021:
            return a1 ^ 2047 | a3 ^ a0 & a2;
        case 1022:
            return a0 ^ a2 | a3 ^ a1 & a2;
        case 1023:
            return a0 ^ a1 | a3 ^ a1 & a2;
        case 1024:
            return a2 ^ a2 & (a0 ^ a1 | a1 ^ a3);
        case 1025:
            return a0 ^ a0 & (a3 ^ a1 & a2);
        case 1026:
            return a1 & (a2 ^ a2 & (a0 ^ a3));
        case 1027:
            return a2 & (a3 ^ 2047 ^ a0 & a1);
        case 1028:
            return a0 & a1 & a2;
        case 1029:
            return a0 ^ 2047 ^ (a1 & a2 | a0 ^ a3);
        case 1030:
            return a1 ^ 2047 ^ (a0 & a2 | a1 ^ a3);
        case 1031:
            return a2 & (a0 ^ (a0 ^ a1) & (a1 ^ a3));
        case 1032:
            return a3 & ~(a0 ^ a2 | a0 ^ a1);
        case 1033:
            return a3 ^ (a1 ^ a2 | a3 & (a0 ^ a1));
        case 1034:
            return a3 ^ (a0 ^ a2 | a3 & (a0 ^ a1));
        case 1035:
            return a3 ^ (a0 ^ a1 | a3 & (a1 ^ a2));
        case 1036:
            return 2047 ^ (a0 ^ a1 | a3 & (a1 ^ a2));
        case 1037:
            return 2047 ^ (a0 ^ a2 | a3 & (a0 ^ a1));
        case 1038:
            return 2047 ^ (a1 ^ a2 | a3 & (a0 ^ a1));
        case 1039:
            return a3 ^ (a0 ^ a2 | a0 ^ a1 & a3);
        case 1040:
            return a0 ^ a0 & (a2 ^ a1 & a3);
        case 1041:
            return a1 ^ a2 ^ a3 & (a0 | a1 ^ a2);
        case 1042:
            return a0 ^ (a3 ^ 2047 | a0 & (a1 ^ a2));
        case 1043:
            return a1 ^ a0 & a2 ^ a3 & (a0 | a1);
        case 1044:
            return a0 ^ (a1 ^ a2) & (a0 | ~a3);
        case 1045:
            return a0 & (a0 ^ a3 & (a1 ^ a2));
        case 1046:
            return a1 ^ a2 ^ (a0 | a2 ^ a1 & a3);
        case 1047:
            return a2 ^ a3 & (a1 ^ (a0 | a1 ^ a2));
        case 1048:
            return a2 ^ (a1 ^ a3 | a2 & (a0 ^ a1));
        case 1049:
            return a1 ^ a3 ^ a2 & (a0 | a1 ^ a3);
        case 1050:
            return a1 ^ (a2 ^ 2047 | a1 & (a0 ^ a3));
        case 1051:
            return a1 ^ a3 ^ a2 & (a0 | a1 ^ a2);
        case 1052:
            return a1 ^ a2 ^ (a0 | 2047 ^ a1 & a2);
        case 1053:
            return a3 ^ (a1 ^ a2 | a2 & (a0 ^ a3));
        case 1054:
            return a1 ^ a2 ^ (a0 | a3 ^ a1 & a2);
        case 1055:
            return a1 ^ (a1 | a3) ^ a2 & (a0 | a1 ^ a3);
        case 1056:
            return a1 & (a2 ^ ~(a0 & a3));
        case 1057:
            return a1 ^ (a3 ^ 2047 | a1 & (a0 ^ a2));
        case 1058:
            return a0 ^ a2 ^ a3 & (a1 | a0 ^ a2);
        case 1059:
            return a0 ^ a1 & a2 ^ a3 & (a0 | a1);
        case 1060:
            return a0 ^ a2 ^ (a1 | a3 & (a0 ^ a2));
        case 1061:
            return a0 ^ a2 ^ (a1 | a2 ^ a0 & a3);
        case 1062:
            return a1 & (a0 ^ a2 ^ (a0 | a3));
        case 1063:
            return a2 ^ a3 & (a0 ^ (a1 | a0 ^ a2));
        case 1064:
            return a2 ^ (a0 ^ a3 | a2 & (a0 ^ a1));
        case 1065:
            return a0 ^ (a2 ^ 2047 | a0 & (a1 ^ a3));
        case 1066:
            return a0 ^ a3 ^ a2 & (a1 | a0 ^ a3);
        case 1067:
            return a0 ^ a3 ^ a2 & (a1 | a0 ^ a2);
        case 1068:
            return a0 ^ a2 ^ (a1 | 2047 ^ a0 & a2);
        case 1069:
            return a0 ^ a2 ^ (a1 | a3 ^ a0 & a2);
        case 1070:
            return a3 ^ (a0 ^ a2 | a2 & (a1 ^ a3));
        case 1071:
            return a0 ^ (a0 | a3) ^ a2 & (a1 | a0 ^ a3);
        case 1072:
            return a2 ^ (a0 ^ a1 | a2 & (a1 ^ a3));
        case 1073:
            return a1 ^ (a0 | a1) & (a2 ^ a0 & a3);
        case 1074:
            return a0 ^ (a0 | a1) & (a2 ^ a1 & a3);
        case 1075:
            return a0 ^ a1 ^ a2 ^ a2 & (a3 ^ (a0 | a1));
        case 1076:
            return a0 ^ a1 ^ a2 & (a0 | a1);
        case 1077:
            return a0 ^ a2 ^ (a1 | a2 & (a0 ^ a3));
        case 1078:
            return a1 ^ a2 ^ (a0 | a2 & (a1 ^ a3));
        case 1079:
            return (a0 | a1) & (a2 ^ a3 & (a0 ^ a1));
        case 1080:
            return a2 ^ 2047 ^ a0 & a1 & a3;
        case 1081:
            return a1 ^ a2 ^ a3 & (a0 | a1 ^ a3);
        case 1082:
            return a0 ^ a2 ^ a3 & (a1 | a0 ^ a3);
        case 1083:
            return a0 ^ a1 ^ a2 ^ 2047 ^ a3 & (a0 | a1);
        case 1084:
            return a0 ^ a2 ^ (a1 | a0 ^ (a0 | a3));
        case 1085:
            return a0 ^ a2 ^ (a1 | 2047 ^ a0 & a3);
        case 1086:
            return a1 ^ a2 ^ (a0 | 2047 ^ a1 & a3);
        case 1087:
            return a2 ^ a3 & (2047 ^ a0 & a1);
        case 1088:
            return a0 & a1 & a3;
        case 1089:
            return a1 ^ a3 ^ (a0 | 2047 ^ a1 & a3);
        case 1090:
            return a0 ^ a3 ^ (a1 | 2047 ^ a0 & a3);
        case 1091:
            return a0 ^ a1 ^ a3 & (a0 | a1);
        case 1092:
            return a0 ^ a1 ^ (a0 | a1 | a3 ^ 2047);
        case 1093:
            return a0 & (a1 | a0 ^ a3);
        case 1094:
            return a1 & (a0 | a1 ^ a3);
        case 1095:
            return a0 & a1 | a3 ^ 2047;
        case 1096:
            return 2047 ^ (a0 ^ a1 | a2 & (a1 ^ a3));
        case 1097:
            return a0 ^ (a1 ^ a3) & (a0 | a2 ^ 2047);
        case 1098:
            return a0 ^ a3 ^ (a1 | a2 & (a0 ^ a3));
        case 1099:
            return a0 ^ a3 ^ (a1 | a0 ^ (a0 | a2));
        case 1100:
            return a0 ^ a1 ^ (a0 | a1 | a2 ^ 2047);
        case 1101:
            return a0 ^ 2047 ^ (a1 | a2 & (a0 ^ a3));
        case 1102:
            return a1 ^ 2047 ^ (a0 | a2 & (a1 ^ a3));
        case 1103:
            return a3 ^ (a0 ^ a1 | a2 & (a1 ^ a3));
        case 1104:
            return 2047 ^ (a0 ^ a3 | a2 & (a0 ^ a1));
        case 1105:
            return a0 & ~(a2 & (a1 ^ a3));
        case 1106:
            return a0 ^ a2 & (a3 ^ (a1 | a0 ^ a3));
        case 1107:
            return a0 ^ a2 & (a3 ^ (a1 | a0 ^ a2));
        case 1108:
            return a0 & (a1 | a0 ^ a2);
        case 1109:
            return a0 ^ a2 & (2047 ^ (a1 | a0 ^ a3));
        case 1110:
            return a3 ^ (a0 ^ 2047 | a2 & (a1 ^ a3));
        case 1111:
            return a0 ^ a2 & (a0 ^ a1) & (a1 ^ a3);
        case 1112:
            return a0 ^ 2047 ^ (a0 ^ a2 | a1 & a3);
        case 1113:
            return a2 ^ (a1 ^ a3 | a1 & (a0 ^ a2));
        case 1114:
            return a0 ^ a3 ^ (a1 | a2 ^ a0 & a3);
        case 1115:
            return a0 ^ a3 ^ (a1 | a3 & (a0 ^ a2));
        case 1116:
            return a0 ^ 2047 ^ (a1 | a3 & (a0 ^ a2));
        case 1117:
            return a0 ^ a3 & (a3 ^ (a1 | a0 ^ a2));
        case 1118:
            return a2 ^ (a1 ^ 2047 | a3 & (a0 ^ a2));
        case 1119:
            return a0 & a1 | a3 ^ (a1 | a2);
        case 1120:
            return 2047 ^ (a1 ^ a3 | a2 & (a0 ^ a1));
        case 1121:
            return a1 ^ a2 & (a3 ^ (a0 | a1 ^ a3));
        case 1122:
            return a1 & (a3 ^ a2 & (a0 ^ a1));
        case 1123:
            return a1 ^ a2 & (a3 ^ (a0 | ~a1));
        case 1124:
            return a1 & (a0 | a1 ^ a2);
        case 1125:
            return a3 ^ (a1 ^ 2047 | a2 & (a0 ^ a3));
        case 1126:
            return a1 ^ a2 & (a2 ^ (a0 | a1 ^ a3));
        case 1127:
            return a0 ^ (a0 ^ a1) & (a3 ^ a1 & a2);
        case 1128:
            return a1 ^ 2047 ^ (a1 ^ a2 | a0 & a3);
        case 1129:
            return a1 ^ a3 ^ (a0 | a2 ^ a1 & a3);
        case 1130:
            return a2 ^ (a0 ^ a3 | a0 & (a1 ^ a2));
        case 1131:
            return a1 ^ a3 ^ (a0 | a3 & (a1 ^ a2));
        case 1132:
            return a1 ^ 2047 ^ (a0 | a3 & (a1 ^ a2));
        case 1133:
            return a2 ^ (a0 ^ 2047 | a3 & (a1 ^ a2));
        case 1134:
            return a1 ^ a3 & (2047 ^ (a0 | a1 ^ a2));
        case 1135:
            return a0 & a1 | a3 ^ (a0 | a2);
        case 1136:
            return a2 ^ (a0 ^ a2 | a0 ^ a1 & a3);
        case 1137:
            return a1 ^ (a1 | a2) ^ a3 & (a0 | a1 ^ a2);
        case 1138:
            return a0 ^ (a0 | a2) ^ a3 & (a1 | a0 ^ a2);
        case 1139:
            return (a0 | a1) & (a3 ^ a2 & (a0 ^ a1));
        case 1140:
            return a2 ^ (a0 ^ a1 | a3 & (a1 ^ a2));
        case 1141:
            return a0 ^ a3 & (a0 ^ a1) & (a1 ^ a2);
        case 1142:
            return a0 ^ (a0 ^ a1) & (a2 ^ a1 & a3);
        case 1143:
            return a2 ^ a3 & (a0 ^ a2 | a0 ^ a1);
        case 1144:
            return a2 ^ (a0 ^ a1 | a3 ^ a1 & a2);
        case 1145:
            return a2 ^ (a0 ^ a2 | a3 ^ a1 & a2);
        case 1146:
            return a2 ^ (a1 ^ 2047 | a3 ^ a0 & a2);
        case 1147:
            return a2 ^ a3 ^ a0 & a1 & a2;
        case 1148:
            return a0 & a1 | a2 ^ 2047;
        case 1149:
            return a0 & a1 | a2 ^ (a1 | a3);
        case 1150:
            return a0 & a1 | a2 ^ (a0 | a3);
        case 1151:
            return a3 ^ a2 & (a0 ^ a1 | a1 ^ a3);
        case 1152:
            return a2 & a3 & (a0 ^ a1 ^ a3);
        case 1153:
            return a2 ^ a2 & (a1 ^ a0 & a3);
        case 1154:
            return a2 & (a0 ^ ~(a1 & a3));
        case 1155:
            return a2 & (a0 ^ a1 ^ a3);
        case 1156:
            return a2 ^ a2 & (a0 ^ a1);
        case 1157:
            return a2 & (a0 ^ a3 & (a1 ^ a2));
        case 1158:
            return a2 & (a1 ^ a3 & (a0 ^ a2));
        case 1159:
            return a2 & ~(a3 & (a0 ^ a1));
        case 1160:
            return a0 ^ (a1 ^ 2047 | a0 & (a2 ^ a3));
        case 1161:
            return a1 ^ (a0 ^ a3 | a1 & (a0 ^ a2));
        case 1162:
            return a0 ^ (a1 ^ a3 | a0 & (a2 ^ a3));
        case 1163:
            return a0 ^ (a1 ^ a3 | a2 ^ (a0 | a1 & a2));
        case 1164:
            return a0 ^ ~(a1 & a2) & (a0 | a1 ^ a3);
        case 1165:
            return a1 ^ 2047 ^ a0 & (a3 ^ a1 & (a2 ^ a3));
        case 1166:
            return a0 ^ 2047 ^ a1 & (a3 ^ a0 & (a2 ^ a3));
        case 1167:
            return a3 ^ (a0 ^ a1 | a0 & (a2 ^ a3));
        case 1168:
            return a1 ^ (a0 ^ a2 | a1 & (a2 ^ a3));
        case 1169:
            return a0 ^ a1 ^ (a2 & a3 | a0 ^ (a0 | a1));
        case 1170:
            return a0 ^ (a2 ^ a1 & a3) & (a0 | a1 ^ a3);
        case 1171:
            return a1 ^ (a0 ^ a2 & a3 | a2 ^ (a0 | a1));
        case 1172:
            return a0 ^ (a1 ^ a2) & (a0 | a2 & a3);
        case 1173:
            return a0 ^ (a1 ^ a2) & (a0 ^ a2 | a1 ^ a3);
        case 1174:
            return a0 ^ a2 ^ a1 & (a0 | a2 & a3);
        case 1175:
            return a0 ^ a1 ^ (a2 & a3 | a1 & (a0 ^ a3));
        case 1176:
            return a3 & (a1 ^ ~(a0 & a2));
        case 1177:
            return a1 ^ 2047 ^ a0 & a2 & a3;
        case 1178:
            return 2047 ^ a0 & a2 ^ a1 & a3;
        case 1179:
            return a1 ^ a3 ^ a0 & a2;
        case 1180:
            return a1 ^ 2047 ^ a0 & a2;
        case 1181:
            return a1 ^ a0 & a2 ^ (a1 | a3);
        case 1182:
            return a1 ^ a2 ^ (a0 | a2 ^ a3);
        case 1183:
            return 2047 ^ a3 & (a1 ^ a0 & a2);
        case 1184:
            return a0 ^ (a1 ^ a2 | a0 & (a2 ^ a3));
        case 1185:
            return a0 ^ (a0 | a1 ^ a2) & (a3 ^ a1 & a2);
        case 1186:
            return a0 ^ a1 ^ (a2 & a3 | a0 ^ a0 & a1);
        case 1187:
            return a0 ^ (a1 ^ a2 & a3 | a2 ^ (a0 | a1));
        case 1188:
            return a1 ^ (a0 ^ a2) & (a1 | a0 ^ a3);
        case 1189:
            return a0 ^ a2 ^ (a1 | a0 & (a2 ^ a3));
        case 1190:
            return a0 ^ (a1 ^ a2 | a2 ^ (a0 | a1 & a3));
        case 1191:
            return a0 ^ a1 ^ (a2 & a3 | a0 & (a1 ^ a3));
        case 1192:
            return a3 & (a0 ^ ~(a1 & a2));
        case 1193:
            return 2047 ^ a1 & a2 ^ a0 & a3;
        case 1194:
            return a0 ^ 2047 ^ a1 & a2 & a3;
        case 1195:
            return a0 ^ a3 ^ a1 & a2;
        case 1196:
            return a0 ^ 2047 ^ a1 & a2;
        case 1197:
            return a0 ^ a2 ^ (a1 | a2 ^ a3);
        case 1198:
            return a0 ^ (a0 | a3) ^ a1 & a2;
        case 1199:
            return 2047 ^ a3 & (a0 ^ a1 & a2);
        case 1200:
            return a3 & (a0 ^ a1 ^ a2);
        case 1201:
            return a1 ^ a2 ^ a0 & a3;
        case 1202:
            return a0 ^ a2 ^ a1 & a3;
        case 1203:
            return a0 ^ a1 ^ a2 & a3;
        case 1204:
            return a0 ^ a1 ^ a2;
        case 1205:
            return a0 ^ a3 & (a1 ^ a2);
        case 1206:
            return a1 ^ a3 & (a0 ^ a2);
        case 1207:
            return a2 ^ a3 & (a0 ^ a1);
        case 1208:
            return a0 ^ (a1 ^ a2 | a3 ^ (a0 | a1 & a3));
        case 1209:
            return a1 ^ (a0 ^ a2 & a3 | a3 ^ (a0 | a1));
        case 1210:
            return a0 ^ (a1 ^ a2 & a3 | a3 ^ (a0 | a1));
        case 1211:
            return a0 ^ a1 ^ 2047 ^ (a2 ^ a3) & (a0 | a1);
        case 1212:
            return a0 ^ a1 ^ a3 ^ (a2 ^ a3) & (a0 | a1);
        case 1213:
            return a0 ^ a2 ^ (a1 | a3 ^ (a0 | a2 & a3));
        case 1214:
            return a0 ^ (a1 ^ a2 | a0 ^ (a0 | a1 ^ a3));
        case 1215:
            return a3 ^ (a0 | a1) & (a2 ^ a0 & a1 & a3);
        case 1216:
            return a0 ^ (a0 | a1 ^ a2) & (2047 ^ a1 & a3);
        case 1217:
            return a0 ^ (a1 ^ a3) & (a0 | a2 & a3);
        case 1218:
            return a1 ^ (a0 ^ a3) & (a1 | a0 ^ a2);
        case 1219:
            return a0 ^ a1 ^ a2 ^ (a2 ^ a3) & (a0 | a1);
        case 1220:
            return a0 ^ a1 ^ (a0 | a1 | a2 & a3);
        case 1221:
            return a0 ^ a1 ^ (a1 | a2 ^ a0 & (a2 ^ a3));
        case 1222:
            return a0 ^ a1 ^ (a0 | a2 ^ a1 & (a2 ^ a3));
        case 1223:
            return a0 & a1 | a2 & (a3 ^ (a0 | a1));
        case 1224:
            return a3 & (a0 ^ a1 ^ a3);
        case 1225:
            return a1 ^ 2047 ^ a0 & a3;
        case 1226:
            return a0 ^ 2047 ^ a1 & a3;
        case 1227:
            return a0 ^ a1 ^ a3;
        case 1228:
            return a0 ^ a1 ^ 2047;
        case 1229:
            return a0 ^ a1 ^ (a1 | a3);
        case 1230:
            return a0 ^ a1 ^ (a0 | a3);
        case 1231:
            return 2047 ^ a3 & (a0 ^ a1);
        case 1232:
            return a3 & (a0 ^ a1 ^ (a1 | a2));
        case 1233:
            return a1 ^ (a1 | a2) ^ a0 & a3;
        case 1234:
            return a0 ^ a2 & (a2 ^ a1 & a3);
        case 1235:
            return a0 ^ a2 & (a1 ^ a3);
        case 1236:
            return a0 ^ a1 ^ (a1 | a2);
        case 1237:
            return a0 ^ a1 ^ (a1 | a2 & a3);
        case 1238:
            return a0 ^ a2 & (a1 ^ (a0 | a3));
        case 1239:
            return a2 ^ a3 & (a0 ^ a1 & a2);
        case 1240:
            return a1 ^ 2047 ^ a0 & (a2 ^ a1 & (a2 ^ a3));
        case 1241:
            return a0 ^ (a1 ^ a3) & (a3 ^ a0 & (a2 ^ a3));
        case 1242:
            return a0 ^ a3 ^ (a1 | a0 & (a2 ^ a3));
        case 1243:
            return a0 ^ a3 ^ (a1 | a2 ^ (a0 | a2 & a3));
        case 1244:
            return a0 ^ a1 ^ (a1 | a3 ^ a0 & (a2 ^ a3));
        case 1245:
            return a0 ^ 2047 ^ (a1 | a0 & (a2 ^ a3));
        case 1246:
            return 2047 ^ (a1 | a2) & (a0 ^ a1 & (a0 | a3));
        case 1247:
            return a0 & a1 | a3 ^ (a1 | a0 & a2);
        case 1248:
            return a3 & (a1 ^ a2 & (a0 ^ a3));
        case 1249:
            return a1 ^ a2 & ~(a0 & a3);
        case 1250:
            return a0 ^ (a0 | a2) ^ a1 & a3;
        case 1251:
            return a1 ^ a2 & (a0 ^ a3);
        case 1252:
            return a0 ^ a1 ^ (a0 | a2);
        case 1253:
            return a0 ^ a3 & (a1 ^ (a0 | a2));
        case 1254:
            return a0 ^ a1 ^ (a0 | a2 & a3);
        case 1255:
            return a2 ^ a3 & (a1 ^ a0 & a2);
        case 1256:
            return a0 ^ 2047 ^ a1 & (a2 ^ a0 & (a2 ^ a3));
        case 1257:
            return a0 ^ a3 ^ a1 & (a0 | a2 & a3);
        case 1258:
            return a0 ^ (a1 ^ a3 | (a2 ^ a3) & (a0 ^ a1));
        case 1259:
            return a0 ^ (a1 ^ a3 | 2047 ^ (a0 | a1 & a2));
        case 1260:
            return a0 ^ a1 ^ (a0 | a3 ^ a1 & (a2 ^ a3));
        case 1261:
            return 2047 ^ a0 & a1 ^ (a1 & a2 | a0 & a3);
        case 1262:
            return a0 ^ 2047 ^ a1 & (a0 | a2 & a3);
        case 1263:
            return a0 & a1 | a3 ^ (a0 | a1 & a2);
        case 1264:
            return a2 ^ (a0 ^ a1 | a0 & (a2 ^ a3));
        case 1265:
            return a0 ^ a1 ^ (a2 & a3 | a1 & (a0 ^ a2));
        case 1266:
            return a0 ^ a1 ^ (a2 & a3 | a0 & (a1 ^ a2));
        case 1267:
            return a2 ^ (a0 | a1) & (a3 ^ a0 & a1 & a2);
        case 1268:
            return a0 & a1 | a3 & (a0 ^ a1 ^ a2);
        case 1269:
            return a0 & a1 | a1 ^ a2 ^ a0 & a3;
        case 1270:
            return a0 & a1 | a2 ^ (a0 | a1 & a3);
        case 1271:
            return a0 ^ a1 ^ (a2 & a3 | a0 & a1);
        case 1272:
            return a2 ^ (a2 ^ a3 | a0 ^ a1);
        case 1273:
            return 2047 ^ a2 & (a1 ^ a0 & a3);
        case 1274:
            return 2047 ^ a2 & (a0 ^ a1 & a3);
        case 1275:
            return a3 ^ a2 & (a0 ^ a1);
        case 1276:
            return 2047 ^ a2 & (a0 ^ a1);
        case 1277:
            return a3 ^ a2 & (a0 ^ a1 & a3);
        case 1278:
            return a3 ^ a2 & (a1 ^ a0 & a3);
        case 1279:
            return 2047 ^ a2 & a3 & (a0 ^ a1);
        case 1280:
            return a0 & a2 & a3;
        case 1281:
            return a1 ^ (a3 ^ 2047 | a1 ^ a0 & a2);
        case 1282:
            return a2 ^ a2 & (a0 ^ a3);
        case 1283:
            return a1 ^ a0 & a2 ^ a1 & a3;
        case 1284:
            return a2 ^ a2 & (a0 ^ (a1 | a3));
        case 1285:
            return a0 & a2;
        case 1286:
            return a1 ^ a3 & (a1 ^ a0 & a2);
        case 1287:
            return a2 & (a0 | a2 ^ a3);
        case 1288:
            return a0 ^ (a2 ^ a3) & (a0 | a1 ^ 2047);
        case 1289:
            return 2047 ^ (a0 ^ a2 | a1 & (a2 ^ a3));
        case 1290:
            return a0 ^ (a2 ^ a3) & (a0 | a1 ^ a3);
        case 1291:
            return a0 ^ (a2 ^ a3) & (a0 ^ a2 | a1 ^ a3);
        case 1292:
            return a0 ^ (a0 | a1 ^ a3) & (a2 ^ (a1 | a3));
        case 1293:
            return a0 ^ a2 ^ (a0 | a3 ^ a1 & (a2 ^ a3));
        case 1294:
            return a3 ^ (a0 ^ a2 | a1 & (a2 ^ a3));
        case 1295:
            return a2 ^ 2047 ^ (a0 | a1 & (a2 ^ a3));
        case 1296:
            return 2047 ^ (a0 ^ a3 | a1 & (a0 ^ a2));
        case 1297:
            return a0 & (a2 & a3 | ~a1);
        case 1298:
            return a0 ^ (a0 | a1) & (a3 ^ (a2 | a0 ^ a1));
        case 1299:
            return a0 ^ a2 ^ (a2 & a3 | a0 & (a1 ^ a2));
        case 1300:
            return a0 & (a3 ^ a1 & (a2 ^ a3));
        case 1301:
            return a0 & a2 | 2047 ^ (a1 | a0 ^ a3);
        case 1302:
            return a0 ^ a2 ^ (a2 & a3 | a0 & a1);
        case 1303:
            return a0 ^ a1 & (a2 ^ (a0 | a2 & a3));
        case 1304:
            return a1 ^ (a2 ^ 2047 | a1 ^ a0 & a3);
        case 1305:
            return a1 ^ (a2 ^ a3 | a0 ^ a1);
        case 1306:
            return a0 ^ a3 ^ (a2 | a0 ^ a1);
        case 1307:
            return a1 ^ (a2 ^ 2047 | a0 ^ a1 & a3);
        case 1308:
            return a0 ^ (a1 | a3) ^ (a2 | a0 ^ a1);
        case 1309:
            return a0 ^ 2047 ^ (a2 | a0 ^ a1);
        case 1310:
            return a0 ^ a3 ^ (a2 & a3 | a0 ^ a1);
        case 1311:
            return a0 & a2 | a3 ^ (a1 | a2);
        case 1312:
            return a0 ^ (a2 ^ a3) & (a0 | a1 ^ a2);
        case 1313:
            return a0 ^ (a0 | a1) & (a2 ^ (a3 | a0 ^ a1));
        case 1314:
            return a0 ^ (a2 ^ a3) & (a0 | a1);
        case 1315:
            return a0 ^ (a2 ^ a3) & (a1 | a0 ^ a2);
        case 1316:
            return a0 ^ (a0 | a1) & (a2 ^ (a1 | a3));
        case 1317:
            return a0 ^ a2 ^ (a0 | a1 | a2 & a3);
        case 1318:
            return a0 ^ (a2 ^ a3) & (a0 ^ a2 | a0 ^ a1);
        case 1319:
            return a0 ^ (a0 | a1) & (a2 ^ (a0 | a3));
        case 1320:
            return a2 ^ 2047 ^ a0 & a3;
        case 1321:
            return a0 ^ a2 ^ (a3 | a0 ^ a1);
        case 1322:
            return a0 ^ a2 ^ a3;
        case 1323:
            return a0 ^ a2 ^ (a3 | a1 ^ 2047);
        case 1324:
            return a0 ^ a2 ^ (a1 | a3);
        case 1325:
            return a0 ^ a2 ^ 2047;
        case 1326:
            return (a1 | a3) ^ a3 & (a0 ^ a2);
        case 1327:
            return a0 ^ a2 ^ (a0 | a3);
        case 1328:
            return a1 ^ a1 & a2 ^ a0 & a3;
        case 1329:
            return a1 ^ (a3 ^ 2047 | a0 ^ a1 & a2);
        case 1330:
            return a0 ^ a2 ^ a3 & (a1 | a2);
        case 1331:
            return a0 ^ a1 & (a2 ^ a3);
        case 1332:
            return a0 ^ a2 ^ (a1 | a2 & a3);
        case 1333:
            return a0 ^ a1 ^ a1 & a2;
        case 1334:
            return a1 ^ a3 & (a0 ^ a1 & a2);
        case 1335:
            return a2 ^ a3 & (a0 ^ (a1 | a2));
        case 1336:
            return a0 ^ (a2 ^ a3) & (a1 ^ a2 | a0 ^ a3);
        case 1337:
            return a0 ^ a3 ^ (a2 & a3 | a0 & (a1 ^ a3));
        case 1338:
            return a0 ^ (a2 ^ a3) & (a1 | a0 ^ a3);
        case 1339:
            return a0 ^ (a2 ^ a3) & (a1 | ~a0);
        case 1340:
            return a2 ^ 2047 ^ a0 & (a1 | a2 & a3);
        case 1341:
            return 2047 ^ (a0 ^ a2) & (a1 | a0 ^ a3);
        case 1342:
            return a0 ^ a2 ^ a3 | a0 & (a1 ^ a3);
        case 1343:
            return a0 ^ (a1 | a0 ^ a3) & (a2 ^ (a0 | a3));
        case 1344:
            return a0 ^ (a0 | a1 ^ a2) & (a3 ^ (a1 | a2));
        case 1345:
            return a0 & (a2 ^ a1 & (a2 ^ a3));
        case 1346:
            return a0 ^ (a0 | a1) & (a3 ^ (a1 | a2));
        case 1347:
            return a3 ^ 2047 ^ a0 & (a1 | a2 & a3);
        case 1348:
            return a0 & (a1 | a2 & a3);
        case 1349:
            return a2 ^ (a0 ^ a2) & (a1 | a0 ^ a3);
        case 1350:
            return a0 & a1 | a2 ^ a2 & (a0 ^ a3);
        case 1351:
            return (a1 | a2) & (a0 | a1 & (a1 ^ a3));
        case 1352:
            return a3 ^ a3 & (a0 ^ (a1 | a2));
        case 1353:
            return a0 ^ (a1 | a2) ^ (a3 | a0 ^ a1);
        case 1354:
            return a0 ^ a3 ^ (a1 | a2);
        case 1355:
            return a0 ^ a3 ^ (a1 | a2 & a3);
        case 1356:
            return a0 ^ a1 ^ (a1 | a2 ^ a3);
        case 1357:
            return a0 ^ 2047 ^ (a1 | a2);
        case 1358:
            return a0 ^ (a2 ^ a3) & (a1 ^ (a0 | a3));
        case 1359:
            return a0 ^ (a1 | a2) ^ (a0 | a3);
        case 1360:
            return a0 & a3;
        case 1361:
            return a0 ^ 2047 ^ (a3 | a0 ^ a1);
        case 1362:
            return a0 ^ a3 ^ 2047;
        case 1363:
            return a0 ^ a1 & (a1 ^ a3);
        case 1364:
            return a0 ^ 2047 ^ (a1 | a3);
        case 1365:
            return a0;
        case 1366:
            return a1 ^ a3 & (a0 ^ a1);
        case 1367:
            return a0 | a3 ^ 2047;
        case 1368:
            return a0 ^ a3 ^ (a0 | a2 ^ a1 & (a2 ^ a3));
        case 1369:
            return a0 & a3 | 2047 ^ (a1 | a0 ^ a2);
        case 1370:
            return a0 ^ a3 ^ (a0 | a1 | a2 & a3);
        case 1371:
            return 2047 ^ (a0 ^ a3) & (a1 | a0 ^ a2);
        case 1372:
            return a3 ^ (a0 ^ a3) & (a1 | a0 ^ a2);
        case 1373:
            return a0 | a1 ^ (a1 | a2 ^ a3);
        case 1374:
            return a0 & a3 | a3 ^ (a1 | a0 ^ a2);
        case 1375:
            return a0 | a3 ^ (a1 | a2 & a3);
        case 1376:
            return a1 ^ a2 & (a1 ^ a0 & a3);
        case 1377:
            return a0 ^ a2 ^ (a2 & a3 | a0 ^ a1);
        case 1378:
            return (a1 | a2) ^ a2 & (a0 ^ a3);
        case 1379:
            return a1 ^ a2 & (a0 ^ a1 & a3);
        case 1380:
            return a0 ^ (a2 ^ a3) & (a1 ^ (a0 | a2));
        case 1381:
            return a1 ^ a2 & (a0 ^ a1);
        case 1382:
            return a0 ^ (a2 ^ a3) & (a0 ^ a1);
        case 1383:
            return (a1 | a2) & (a0 | a2 ^ a3);
        case 1384:
            return a2 ^ (a0 ^ a3 | a1 & (a0 ^ a2));
        case 1385:
            return a0 ^ a3 ^ (a2 & a3 | a0 & a1);
        case 1386:
            return a0 ^ (a2 ^ a3) & (a0 ^ a1 | a1 ^ a3);
        case 1387:
            return a0 & (a1 ^ a2) | a0 ^ a2 ^ a3;
        case 1388:
            return a0 & a1 | a2 ^ 2047 ^ a0 & a3;
        case 1389:
            return a0 & a2 | a2 ^ (a1 | a0 ^ a3);
        case 1390:
            return a0 & a1 | a0 ^ a2 ^ a3;
        case 1391:
            return a0 ^ a2 ^ 2047 | a1 & (a2 ^ a3);
        case 1392:
            return a3 ^ 2047 ^ (a0 | a1 & (a2 ^ a3));
        case 1393:
            return a0 ^ a1 & (a3 ^ (a0 | a2 & a3));
        case 1394:
            return a0 ^ (a0 | a1) & (a3 ^ (a0 | a2));
        case 1395:
            return a0 ^ (a1 | a0 ^ a2) & (a3 ^ (a0 | a2));
        case 1396:
            return (a1 | a3) & (a0 | a1 ^ a1 & a2);
        case 1397:
            return a0 | a2 ^ (a1 | a2 & a3);
        case 1398:
            return a1 & (a2 ^ a3) | a0 ^ a3 ^ 2047;
        case 1399:
            return a0 | a1 & (a2 ^ a3);
        case 1400:
            return a3 & (a0 | a2 ^ a3);
        case 1401:
            return a0 & a3 | a2 ^ (a1 | a3);
        case 1402:
            return a0 ^ a3 ^ (a0 | a2);
        case 1403:
            return a3 ^ a2 & (a0 ^ (a1 | a3));
        case 1404:
            return a0 ^ (a1 | a3) ^ (a0 | a2);
        case 1405:
            return a0 | a2 ^ 2047;
        case 1406:
            return (a1 | a3) & (a0 | a2 ^ a3);
        case 1407:
            return a0 | a2 ^ a3;
        case 1408:
            return a2 & (a1 ^ (~a0 | a1 ^ a3));
        case 1409:
            return a2 & (a0 ^ (a1 ^ a3) & (a0 ^ a3));
        case 1410:
            return a2 & (a0 ^ a3 ^ (a0 | a1));
        case 1411:
            return a2 & (2047 ^ a1 & (a0 ^ a3));
        case 1412:
            return a2 & (a3 ^ a1 & (a0 ^ a3));
        case 1413:
            return a2 & (a0 | a1 ^ a2);
        case 1414:
            return a2 & (2047 ^ (a0 ^ a1) & (a0 ^ a3));
        case 1415:
            return a2 & (a0 | a1 ^ a3);
        case 1416:
            return a2 ^ a3 ^ (a0 | a2 ^ a1 & a3);
        case 1417:
            return a1 ^ (a1 ^ a2 | 2047 ^ a0 & a3);
        case 1418:
            return a2 ^ a3 ^ (a0 | a3 & (a1 ^ a2));
        case 1419:
            return a1 ^ (a0 ^ a3 | a0 & (a1 ^ a2));
        case 1420:
            return a1 ^ (a0 ^ 2047 | a3 & (a1 ^ a2));
        case 1421:
            return a2 ^ 2047 ^ (a0 | a3 & (a1 ^ a2));
        case 1422:
            return a1 ^ a3 & (~a0 | a1 ^ a2);
        case 1423:
            return a1 ^ (a1 ^ a2 | a0 ^ (a0 | a3));
        case 1424:
            return a3 & (a0 ^ (a0 ^ a2) & (a1 ^ a2));
        case 1425:
            return a1 ^ (a0 ^ a2 | a0 ^ a1 & a3);
        case 1426:
            return a0 ^ (a3 ^ 2047 | (a0 ^ a2) & (a1 ^ a2));
        case 1427:
            return a0 ^ (a1 ^ a2 & a3) & (a2 ^ a0 & a3);
        case 1428:
            return a0 ^ (a1 ^ a2) & (a2 ^ a0 & a3);
        case 1429:
            return a0 ^ a3 & (a0 ^ a2) & (a1 ^ a2);
        case 1430:
            return a1 ^ a3 & (a0 ^ a2 | a0 ^ a1);
        case 1431:
            return a0 ^ (a0 ^ a2) & (a2 ^ a1 & a3);
        case 1432:
            return a1 ^ (a0 ^ a2 | a3 ^ a1 & a2);
        case 1433:
            return a1 ^ (a0 ^ a1 | a3 ^ a1 & a2);
        case 1434:
            return a1 ^ a3 ^ a0 & a1 & a2;
        case 1435:
            return 2047 ^ a1 & (a3 ^ a0 & a2);
        case 1436:
            return a3 ^ a1 & (a3 ^ a0 & a2);
        case 1437:
            return a0 & a2 | a1 ^ 2047;
        case 1438:
            return a1 ^ a3 | a2 ^ a2 & (a0 ^ a1);
        case 1439:
            return a0 & a2 | a1 ^ a3;
        case 1440:
            return a3 & (a2 ^ a1 & (a0 ^ a3));
        case 1441:
            return a1 ^ a2 ^ a0 & a1 & a3;
        case 1442:
            return a0 ^ a2 ^ a3 & (a0 | a1);
        case 1443:
            return a0 ^ a2 & a3 ^ (a1 | a0 & a3);
        case 1444:
            return a0 ^ a2 ^ (a1 | a0 & a3);
        case 1445:
            return a0 ^ a3 & (a2 ^ (a0 | a1));
        case 1446:
            return a1 ^ a3 & (a2 ^ a0 & a1);
        case 1447:
            return a0 ^ a2 ^ (a0 | a1 & a3);
        case 1448:
            return a2 ^ a3 ^ (a0 | a2 & (a1 ^ a3));
        case 1449:
            return a0 ^ (a2 ^ 2047 | (a1 ^ a3) & (a0 ^ a3));
        case 1450:
            return a0 ^ a3 ^ a2 & (a0 | a1);
        case 1451:
            return a2 ^ (a0 ^ a3) & (a1 | a2 ^ 2047);
        case 1452:
            return a0 ^ (a1 | a3) ^ a2 & (a0 | a1);
        case 1453:
            return a0 ^ 2047 ^ a2 & (a0 | a1);
        case 1454:
            return a2 & (a1 ^ a3) | a0 ^ a2 ^ a3;
        case 1455:
            return a0 ^ (a0 | a3) ^ a2 & (a0 | a1);
        case 1456:
            return a1 ^ (a0 ^ a2 | a2 & (a1 ^ a3));
        case 1457:
            return a0 ^ (a1 ^ a2 & a3) & (a3 ^ a0 & a2);
        case 1458:
            return a0 ^ a2 & a3 ^ (a1 | a0 & a2);
        case 1459:
            return (a0 | a2) ^ a1 & (a3 ^ a0 & a2);
        case 1460:
            return a0 ^ a1 ^ a2 & (a1 | a0 ^ a3);
        case 1461:
            return a0 ^ a2 ^ (a1 | a0 & a2);
        case 1462:
            return a2 ^ (a0 ^ a1) & (a3 ^ a0 & a2);
        case 1463:
            return a0 & a2 | a1 ^ a3 & (a0 ^ a2);
        case 1464:
            return a3 & ~(a1 & (a0 ^ a2));
        case 1465:
            return 2047 ^ a1 & (a2 ^ a0 & a3);
        case 1466:
            return a3 ^ (a0 ^ a2) & (a1 | a3 ^ 2047);
        case 1467:
            return (a0 | a3) ^ a1 & (a2 ^ a0 & a3);
        case 1468:
            return a1 ^ (a0 ^ a2 | a1 ^ (a1 | a3));
        case 1469:
            return 2047 ^ (a0 ^ a2) & (a1 | a3 ^ 2047);
        case 1470:
            return a3 ^ a1 & (a2 ^ a0 & a3);
        case 1471:
            return 2047 ^ a1 & a3 & (a0 ^ a2);
        case 1472:
            return a3 & (a2 ^ a1 & (a0 ^ a2));
        case 1473:
            return a2 ^ a1 & (a2 ^ a0 & a3);
        case 1474:
            return a0 ^ (a1 | a2) ^ a3 & (a0 | a1);
        case 1475:
            return a0 ^ a1 ^ a3 & (a1 | a0 ^ a2);
        case 1476:
            return a0 ^ a1 ^ (a1 | a2 ^ a0 & a3);
        case 1477:
            return a0 ^ a1 ^ (a1 | a3 & (a0 ^ a2));
        case 1478:
            return a0 & a1 | a2 & (a1 ^ a3);
        case 1479:
            return a2 ^ a1 & a3 & (a0 ^ a2);
        case 1480:
            return a1 ^ (a0 ^ 2047 | a2 & (a1 ^ a3));
        case 1481:
            return a0 ^ (a1 ^ a3) & (a3 ^ a0 & a2);
        case 1482:
            return a0 ^ a3 ^ (a1 | a0 & a2);
        case 1483:
            return a1 ^ (a0 ^ a3 | a1 ^ (a1 | a2));
        case 1484:
            return a0 ^ a1 ^ (a1 | a3 ^ a0 & a2);
        case 1485:
            return a0 ^ 2047 ^ (a1 | a0 & a2);
        case 1486:
            return 2047 ^ (a0 ^ a1) & (a3 ^ a0 & a2);
        case 1487:
            return a0 & a2 | a0 ^ a1 ^ a3;
        case 1488:
            return a2 ^ (a0 | a1) & (a2 ^ a0 & a3);
        case 1489:
            return a0 ^ a2 & (a1 ^ a3) & (a0 ^ a3);
        case 1490:
            return a0 ^ a2 & (a3 ^ (a0 | a1));
        case 1491:
            return 2047 ^ (a0 ^ a3) & (a1 | a2 ^ 2047);
        case 1492:
            return a0 ^ a1 ^ (a1 | a2 & (a0 ^ a3));
        case 1493:
            return a0 | a1 ^ (a1 | a2);
        case 1494:
            return a2 & (a1 ^ a3) | a0 ^ a3 ^ 2047;
        case 1495:
            return a0 | a2 & (a1 ^ a3);
        case 1496:
            return a3 & (a0 | a1 ^ a3);
        case 1497:
            return a1 ^ 2047 | a0 & a3;
        case 1498:
            return a0 ^ 2047 ^ a3 & (a0 | a1);
        case 1499:
            return a0 ^ a3 ^ (a1 | a0 & a3);
        case 1500:
            return a0 ^ 2047 ^ (a1 | a0 & a3);
        case 1501:
            return a0 | a1 ^ (a1 | a3);
        case 1502:
            return a0 & a1 | a1 ^ a3;
        case 1503:
            return a0 | 2047 ^ a1 & a3;
        case 1504:
            return a1 ^ a2 & (a0 ^ a2 | a1 ^ a3);
        case 1505:
            return a1 ^ a2 & (a0 ^ a1 | a1 ^ a3);
        case 1506:
            return a1 ^ a2 & (a3 ^ a0 & a1);
        case 1507:
            return a2 ^ a1 & (a3 ^ a0 & a2);
        case 1508:
            return a0 & a1 | a3 & (a1 ^ a2);
        case 1509:
            return a0 & a1 | a1 ^ a2;
        case 1510:
            return a2 ^ (a1 | a3) ^ (a0 & a2 | a1 ^ a3);
        case 1511:
            return a0 & a2 | a1 ^ a2 & a3;
        case 1512:
            return a3 & (a3 ^ (a0 ^ a2) & (a0 ^ a1));
        case 1513:
            return a1 ^ a2 | a3 & (a0 ^ a1 ^ a3);
        case 1514:
            return a0 ^ a2 ^ a3 | a3 & (a1 ^ a2);
        case 1515:
            return a3 ^ (a0 ^ a1) & (a2 ^ a0 & a3);
        case 1516:
            return 2047 ^ (a0 ^ a1) & (a2 ^ a0 & a3);
        case 1517:
            return a3 & (a1 ^ a2) | a0 ^ a2 ^ 2047;
        case 1518:
            return a3 ^ (a1 | a2) ^ (a1 ^ a2 | a0 & a3);
        case 1519:
            return 2047 ^ a3 & (a0 ^ a2) & (a0 ^ a1);
        case 1520:
            return a3 & (a0 | a1 ^ a2);
        case 1521:
            return a1 ^ a2 | a0 & a3;
        case 1522:
            return a0 ^ (a0 | a2) ^ a3 & (a0 | a1);
        case 1523:
            return a0 & a3 | a1 ^ a2 & (a0 | a3);
        case 1524:
            return a0 & a3 | a0 ^ a1 ^ a2;
        case 1525:
            return a0 | a3 & (a1 ^ a2);
        case 1526:
            return a0 & a3 | a1 ^ a2 & a3;
        case 1527:
            return a0 | a2 ^ a1 & a3;
        case 1528:
            return a1 ^ (a1 ^ a3 | a0 ^ (a0 | a2));
        case 1529:
            return a0 ^ (a0 ^ a3) & (a3 ^ a1 & a2);
        case 1530:
            return a0 ^ a3 ^ (a0 | a1 & a2);
        case 1531:
            return 2047 ^ a1 & a2 & (a0 ^ a3);
        case 1532:
            return a3 ^ a1 & a2 & (a0 ^ a3);
        case 1533:
            return a0 | 2047 ^ a1 & a2;
        case 1534:
            return 2047 ^ a2 & (a0 ^ a1) & (a0 ^ a3);
        case 1535:
            return a0 | a3 ^ a1 & a2;
        case 1536:
            return a1 & a2 & a3;
        case 1537:
            return a2 & (a1 ^ a3 ^ 2047);
        case 1538:
            return a0 ^ (a3 ^ 2047 | a0 ^ a1 & a2);
        case 1539:
            return a0 ^ a1 & a2 ^ a0 & a3;
        case 1540:
            return a2 & (a1 ^ a2 ^ (a0 | a3));
        case 1541:
            return a0 ^ a3 & (a0 ^ a1 & a2);
        case 1542:
            return a1 & a2;
        case 1543:
            return a2 & (a1 | a3 ^ 2047);
        case 1544:
            return a1 ^ (a2 ^ a3) & (a1 | ~a0);
        case 1545:
            return a1 ^ (a2 ^ a3) & (a1 | a0 ^ a3);
        case 1546:
            return 2047 ^ (a1 ^ a2 | a0 & (a2 ^ a3));
        case 1547:
            return a1 ^ (a2 ^ a3) & (a1 ^ a2 | a0 ^ a3);
        case 1548:
            return a1 ^ (a1 | a0 ^ a3) & (a2 ^ (a0 | a3));
        case 1549:
            return a3 ^ (a1 ^ a2 | a0 & (a2 ^ a3));
        case 1550:
            return a1 ^ a2 ^ (a1 | a3 ^ a0 & (a2 ^ a3));
        case 1551:
            return a2 ^ 2047 ^ (a1 | a0 & (a2 ^ a3));
        case 1552:
            return a1 ^ (a2 ^ a3) & (a1 | a0 ^ a2);
        case 1553:
            return a1 ^ (a2 ^ a3) & (a0 | a1);
        case 1554:
            return a0 ^ (a0 | a1) & (a2 ^ a0 & a1 & a3);
        case 1555:
            return a1 ^ (a2 ^ a3) & (a0 | a1 ^ a2);
        case 1556:
            return a1 ^ (a0 | a1) & (a2 ^ (a0 | a3));
        case 1557:
            return a1 ^ (a2 ^ a3) & (a0 ^ a2 | a0 ^ a1);
        case 1558:
            return a1 ^ a2 ^ (a0 | a1 | a2 & a3);
        case 1559:
            return a1 ^ (a0 | a1) & (a2 ^ (a1 | a3));
        case 1560:
            return a2 ^ 2047 ^ a1 & a3;
        case 1561:
            return a1 ^ a2 ^ a3;
        case 1562:
            return a1 ^ a2 ^ (a3 | a0 ^ a1);
        case 1563:
            return a1 ^ a2 ^ (a3 | a0 ^ a2);
        case 1564:
            return a1 ^ a2 ^ (a0 | a3);
        case 1565:
            return (a0 | a3) ^ a3 & (a1 ^ a2);
        case 1566:
            return a1 ^ a2 ^ 2047;
        case 1567:
            return a1 ^ a2 ^ (a1 | a3);
        case 1568:
            return 2047 ^ (a1 ^ a3 | a0 & (a2 ^ a3));
        case 1569:
            return a0 ^ (a0 | a1) & (a3 ^ a0 & a1 & a2);
        case 1570:
            return a1 ^ a0 & a1 & (a2 ^ a3);
        case 1571:
            return a1 ^ a2 ^ (a2 & a3 | a1 & (a0 ^ a2));
        case 1572:
            return a1 & (a3 ^ a0 & (a2 ^ a3));
        case 1573:
            return a1 ^ a2 ^ (a2 & a3 | a0 & a1);
        case 1574:
            return a1 & a2 | 2047 ^ (a0 | a1 ^ a3);
        case 1575:
            return a1 ^ a0 & (a2 ^ (a1 | a2 & a3));
        case 1576:
            return a0 ^ (a2 ^ 2047 | a0 ^ a1 & a3);
        case 1577:
            return a1 ^ a3 ^ (a2 | a0 ^ a1);
        case 1578:
            return a0 ^ (a2 ^ a3 | a0 ^ a1);
        case 1579:
            return a0 ^ (a2 ^ 2047 | a1 ^ a0 & a3);
        case 1580:
            return a0 ^ a1 & a2 ^ (a0 | a2 ^ a3);
        case 1581:
            return a0 ^ a3 & (a2 ^ a3 | a0 ^ a1);
        case 1582:
            return a0 ^ (a0 ^ a1 | a2 ^ 2047);
        case 1583:
            return a1 & a2 | a3 ^ (a0 | a2);
        case 1584:
            return a0 ^ a0 & a2 ^ a1 & a3;
        case 1585:
            return a1 ^ a2 ^ a3 & (a0 | a2);
        case 1586:
            return a0 ^ (a3 ^ 2047 | a1 ^ a0 & a2);
        case 1587:
            return a1 ^ a0 & (a2 ^ a3);
        case 1588:
            return a1 ^ a2 ^ (a0 | a2 & a3);
        case 1589:
            return a0 ^ a3 & (a1 ^ a0 & a2);
        case 1590:
            return a0 ^ a1 ^ a0 & a2;
        case 1591:
            return a2 ^ a3 & (a1 ^ (a0 | a2));
        case 1592:
            return a1 ^ (a2 ^ a3) & (a0 ^ a2 | a1 ^ a3);
        case 1593:
            return a1 ^ (a2 ^ a3) & (a0 | a1 ^ a3);
        case 1594:
            return a1 ^ a3 ^ (a2 & a3 | a1 & (a0 ^ a3));
        case 1595:
            return a1 ^ (a2 ^ a3) & (a0 | a1 ^ 2047);
        case 1596:
            return a2 ^ 2047 ^ a1 & (a0 | a2 & a3);
        case 1597:
            return a1 ^ a2 ^ a3 | a1 & (a0 ^ a3);
        case 1598:
            return 2047 ^ (a1 ^ a2) & (a0 | a2 & a3);
        case 1599:
            return a1 ^ (a0 | a1 ^ a3) & (a2 ^ (a1 | a3));
        case 1600:
            return a1 ^ (a1 | a0 ^ a2) & (a3 ^ (a0 | a2));
        case 1601:
            return a1 ^ (a0 | a1) & (a3 ^ (a0 | a2));
        case 1602:
            return a1 & (a2 ^ a0 & (a2 ^ a3));
        case 1603:
            return a3 ^ 2047 ^ a1 & (a0 | a2 & a3);
        case 1604:
            return a1 & (a0 | a2 & a3);
        case 1605:
            return a0 & a1 | a2 & (a1 ^ a3 ^ 2047);
        case 1606:
            return a2 ^ (a1 ^ a2) & (a0 | a2 & a3);
        case 1607:
            return a1 & a2 | a0 & (a1 | a0 ^ a3);
        case 1608:
            return a3 & (a1 ^ 2047 ^ (a0 | a2));
        case 1609:
            return a1 ^ a3 ^ (a0 | a2);
        case 1610:
            return a0 ^ a1 & a3 ^ (a0 | a2 ^ a3);
        case 1611:
            return a1 ^ a3 ^ (a0 | a2 & a3);
        case 1612:
            return a0 ^ a1 ^ (a0 | a2 ^ a3);
        case 1613:
            return a0 ^ a3 & (a1 ^ (a0 | a2 ^ 2047));
        case 1614:
            return a1 ^ 2047 ^ (a0 | a2);
        case 1615:
            return a1 ^ (a1 | a3) ^ (a0 | a2);
        case 1616:
            return a0 ^ a2 & (a0 ^ a1 & a3);
        case 1617:
            return (a0 | a2) ^ a2 & (a1 ^ a3);
        case 1618:
            return a0 ^ a2 & (a2 ^ a3 | a0 ^ a1);
        case 1619:
            return a0 ^ a2 & (a1 ^ a0 & a3);
        case 1620:
            return a0 ^ a2 & (a1 ^ (a0 | a3 ^ 2047));
        case 1621:
            return a0 ^ a2 & a3 & (a0 ^ a1);
        case 1622:
            return a0 ^ a2 & (a0 ^ a1);
        case 1623:
            return (a0 | a2) & (a1 | a2 ^ a3);
        case 1624:
            return a2 ^ (a1 ^ a3 | a0 & (a2 ^ a3));
        case 1625:
            return a1 ^ (a2 ^ a3) & (a0 ^ a1 | a1 ^ a3);
        case 1626:
            return a1 ^ a3 ^ (a2 & a3 | a0 & a1);
        case 1627:
            return a1 ^ a2 ^ a3 | a1 & (a0 ^ a2);
        case 1628:
            return a0 & a1 | a2 ^ 2047 ^ a1 & a3;
        case 1629:
            return a0 & a1 | a1 ^ a2 ^ a3;
        case 1630:
            return a1 & a2 | a2 ^ (a0 | a1 ^ a3);
        case 1631:
            return a0 & (a2 ^ a3) | a1 ^ a2 ^ 2047;
        case 1632:
            return a1 & a3;
        case 1633:
            return a1 ^ a3 ^ 2047;
        case 1634:
            return a0 ^ (a0 ^ a1 | a3 ^ 2047);
        case 1635:
            return a0 ^ a1 ^ a0 & a3;
        case 1636:
            return a1 ^ 2047 ^ (a0 | a3);
        case 1637:
            return a0 ^ a3 & (a0 ^ a1);
        case 1638:
            return a1;
        case 1639:
            return a1 | a3 ^ 2047;
        case 1640:
            return a1 ^ a3 ^ (a1 | a2 ^ a0 & (a2 ^ a3));
        case 1641:
            return a1 ^ a3 ^ (a0 | a1 | a2 & a3);
        case 1642:
            return a1 & a3 | 2047 ^ (a0 | a1 ^ a2);
        case 1643:
            return 2047 ^ (a1 ^ a3) & (a0 | a2 & a3);
        case 1644:
            return a3 ^ (a1 ^ a3) & (a0 | a2 & a3);
        case 1645:
            return a1 & a3 | a3 ^ (a0 | a1 ^ a2);
        case 1646:
            return a1 | a0 ^ (a0 | a2 ^ a3);
        case 1647:
            return a1 | a3 ^ (a0 | a2 & a3);
        case 1648:
            return a3 ^ 2047 ^ (a1 | a0 & (a2 ^ a3));
        case 1649:
            return a1 ^ (a0 | a1) & (a3 ^ (a1 | a2));
        case 1650:
            return a1 ^ a0 & (a3 ^ (a1 | a2 & a3));
        case 1651:
            return a1 ^ (a0 | a1 ^ a2) & (a3 ^ (a1 | a2));
        case 1652:
            return (a0 | a3) & (a1 | a0 & (a0 ^ a2));
        case 1653:
            return a0 & (a2 ^ a3) | a1 ^ a3 ^ 2047;
        case 1654:
            return a1 | a2 ^ (a0 | a2 & a3);
        case 1655:
            return a1 | a0 & (a2 ^ a3);
        case 1656:
            return a3 & (a1 | a2 ^ 2047);
        case 1657:
            return a1 ^ a3 ^ (a1 | a2);
        case 1658:
            return a1 & a3 | a2 ^ (a0 | a3);
        case 1659:
            return a3 ^ a2 & (a1 ^ (a0 | a3));
        case 1660:
            return a1 ^ (a1 | a2) ^ (a0 | a3);
        case 1661:
            return (a0 | a3) & (a1 | a2 ^ a3);
        case 1662:
            return a1 | a2 ^ 2047;
        case 1663:
            return a1 | a2 ^ a3;
        case 1664:
            return a2 ^ a2 & (a3 ^ (a1 | a0 ^ a3));
        case 1665:
            return a2 & (a3 ^ a0 & (a1 ^ a2));
        case 1666:
            return a2 & (a0 ^ (a0 ^ a1 | a1 ^ a3));
        case 1667:
            return a2 & (2047 ^ a0 & (a1 ^ a3));
        case 1668:
            return a2 & (a3 ^ a0 & (a1 ^ a3));
        case 1669:
            return a2 & (a0 ^ a3 | a1 ^ a2 ^ a3);
        case 1670:
            return a2 & (a1 | a0 ^ a2);
        case 1671:
            return a2 & (a1 | a0 ^ a3);
        case 1672:
            return a2 ^ a3 ^ (a1 | a2 ^ a0 & a3);
        case 1673:
            return a2 ^ a3 ^ (a1 | a3 & (a0 ^ a2));
        case 1674:
            return a0 ^ (a0 ^ a2 | 2047 ^ a1 & a3);
        case 1675:
            return a0 ^ (a1 ^ a3 | a1 & (a0 ^ a2));
        case 1676:
            return a0 ^ (a1 ^ 2047 | a3 & (a0 ^ a2));
        case 1677:
            return a0 ^ a3 & (a0 ^ a2 | a1 ^ a3);
        case 1678:
            return a2 ^ 2047 ^ (a1 | a3 & (a0 ^ a2));
        case 1679:
            return a0 ^ (a0 ^ a2 | a1 ^ (a1 | a3));
        case 1680:
            return a3 & (a0 ^ a2 ^ a0 & a1);
        case 1681:
            return a1 ^ a2 ^ a3 & (a0 | a1);
        case 1682:
            return a0 ^ a2 ^ a0 & a1 & a3;
        case 1683:
            return a1 ^ a2 & a3 ^ (a0 | a1 & a3);
        case 1684:
            return a1 ^ a2 ^ (a0 | a1 & a3);
        case 1685:
            return a0 ^ a3 & (a2 ^ a0 & a1);
        case 1686:
            return a1 ^ a3 & (a2 ^ (a0 | a1));
        case 1687:
            return a1 ^ a2 ^ (a1 | a0 & a3);
        case 1688:
            return a2 ^ a3 ^ (a1 | a2 & (a0 ^ a3));
        case 1689:
            return a1 ^ a3 ^ a2 & (a0 | a1);
        case 1690:
            return a1 ^ (a2 ^ 2047 | (a1 ^ a3) & (a0 ^ a3));
        case 1691:
            return a2 ^ (a1 ^ a3) & (a0 | a2 ^ 2047);
        case 1692:
            return a1 ^ (a0 | a3) ^ a2 & (a0 | a1);
        case 1693:
            return a1 ^ a2 ^ a3 | a2 & (a0 ^ a3);
        case 1694:
            return a1 ^ 2047 ^ a2 & (a0 | a1);
        case 1695:
            return a1 ^ (a1 | a3) ^ a2 & (a0 | a1);
        case 1696:
            return a3 & (a0 ^ (a0 ^ a2 | a0 ^ a1));
        case 1697:
            return a1 ^ (a3 ^ 2047 | (a0 ^ a2) & (a1 ^ a2));
        case 1698:
            return a0 ^ (a0 ^ a2 | a0 ^ a1 & a3);
        case 1699:
            return a0 ^ a1 & a2 ^ a3 & (a0 | a1 ^ a2);
        case 1700:
            return a0 ^ (a1 ^ a2 | a3 & (a0 ^ a1));
        case 1701:
            return a0 ^ a3 & (a0 ^ a2 | a0 ^ a1);
        case 1702:
            return a0 ^ (a0 ^ a1 | a3 & (a1 ^ a2));
        case 1703:
            return a0 ^ (a0 ^ a2 | a3 & (a0 ^ a1));
        case 1704:
            return a0 ^ (a1 ^ 2047 | a3 ^ a0 & a2);
        case 1705:
            return a0 ^ a3 ^ a0 & a1 & a2;
        case 1706:
            return a0 ^ (a0 ^ a1 | a3 ^ a1 & a2);
        case 1707:
            return 2047 ^ a0 & (a3 ^ a1 & a2);
        case 1708:
            return a3 ^ a0 & (a3 ^ a1 & a2);
        case 1709:
            return a0 ^ a3 | a2 ^ a2 & (a0 ^ a1);
        case 1710:
            return a1 & a2 | a0 ^ 2047;
        case 1711:
            return a1 & a2 | a0 ^ a3;
        case 1712:
            return a0 ^ (a1 ^ a2 | a2 & (a0 ^ a3));
        case 1713:
            return a1 ^ a2 & a3 ^ (a0 | a1 & a2);
        case 1714:
            return a0 ^ a1 & a3 ^ a2 & (a0 | a1 ^ a3);
        case 1715:
            return (a1 | a2) ^ a0 & (a3 ^ a1 & a2);
        case 1716:
            return a0 ^ a1 ^ a2 & (a0 | a1 ^ a3);
        case 1717:
            return a2 ^ (a0 ^ a1) & (a3 ^ a1 & a2);
        case 1718:
            return a1 ^ a2 ^ (a0 | a1 & a2);
        case 1719:
            return a1 & a2 | a0 ^ a3 & (a1 ^ a2);
        case 1720:
            return a3 & (2047 ^ a0 & (a1 ^ a2));
        case 1721:
            return a3 ^ (a1 ^ a2) & (a0 | ~a3);
        case 1722:
            return 2047 ^ a0 & (a2 ^ a1 & a3);
        case 1723:
            return (a1 | a3) ^ a0 & (a2 ^ a1 & a3);
        case 1724:
            return a0 ^ (a1 ^ a2 | a0 ^ (a0 | a3));
        case 1725:
            return a3 ^ a0 & (a2 ^ a1 & a3);
        case 1726:
            return 2047 ^ (a1 ^ a2) & (a0 | ~a3);
        case 1727:
            return 2047 ^ a0 & a3 & (a1 ^ a2);
        case 1728:
            return a3 & (a2 ^ a0 & (a1 ^ a2));
        case 1729:
            return a1 ^ (a0 | a2) ^ a3 & (a0 | a1);
        case 1730:
            return a2 ^ a0 & (a2 ^ a1 & a3);
        case 1731:
            return a0 ^ a1 ^ a3 & (a0 | a1 ^ a2);
        case 1732:
            return a0 ^ a1 ^ (a0 | a2 ^ a1 & a3);
        case 1733:
            return a0 & a1 | a2 & (a0 ^ a3);
        case 1734:
            return a0 ^ a1 ^ (a0 | a3 & (a1 ^ a2));
        case 1735:
            return a2 ^ a0 & a3 & (a1 ^ a2);
        case 1736:
            return a0 ^ (a1 ^ 2047 | a2 & (a0 ^ a3));
        case 1737:
            return a1 ^ a3 ^ (a0 | a1 & a2);
        case 1738:
            return a0 ^ (a1 ^ a3 | a2 & (a0 ^ a1));
        case 1739:
            return a0 ^ (a1 ^ a3 | a0 ^ (a0 | a2));
        case 1740:
            return a0 ^ a1 ^ (a0 | a3 ^ a1 & a2);
        case 1741:
            return 2047 ^ (a0 ^ a1) & (a3 ^ a1 & a2);
        case 1742:
            return a1 ^ 2047 ^ (a0 | a1 & a2);
        case 1743:
            return a1 & a2 | a0 ^ a1 ^ a3;
        case 1744:
            return a0 ^ a2 & (a1 ^ 2047 | a0 ^ a3);
        case 1745:
            return a0 ^ a2 & (a3 ^ a0 & a1);
        case 1746:
            return a0 ^ a2 & (a0 ^ a1 | a1 ^ a3);
        case 1747:
            return a2 ^ a0 & (a3 ^ a1 & a2);
        case 1748:
            return a0 & a1 | a3 & (a0 ^ a2);
        case 1749:
            return a2 ^ (a0 | a3) ^ (a1 & a2 | a0 ^ a3);
        case 1750:
            return a0 ^ a2 | a0 & a1;
        case 1751:
            return a1 & a2 | a0 ^ a2 & a3;
        case 1752:
            return a3 ^ a3 & (a0 ^ a1) & (a1 ^ a2);
        case 1753:
            return a1 ^ a2 ^ a3 | a3 & (a0 ^ a2);
        case 1754:
            return a0 ^ a2 | a3 & (a0 ^ a1 ^ a3);
        case 1755:
            return a3 ^ (a0 ^ a1) & (a2 ^ a1 & a3);
        case 1756:
            return 2047 ^ (a0 ^ a1) & (a2 ^ a1 & a3);
        case 1757:
            return a3 ^ (a0 | a2) ^ (a0 ^ a2 | a1 & a3);
        case 1758:
            return a1 ^ a2 ^ 2047 | a3 & (a0 ^ a2);
        case 1759:
            return 2047 ^ a3 & (a0 ^ a1) & (a1 ^ a2);
        case 1760:
            return a2 ^ (a0 | a1) & (a2 ^ a1 & a3);
        case 1761:
            return a1 ^ a2 & (a3 ^ (a0 | a1));
        case 1762:
            return a0 ^ (a0 ^ a1 | a2 & (a1 ^ a3));
        case 1763:
            return 2047 ^ (a1 ^ a3) & (a0 | a2 ^ 2047);
        case 1764:
            return a0 ^ a1 ^ (a0 | a2 & (a1 ^ a3));
        case 1765:
            return a1 ^ a3 ^ 2047 | a2 & (a0 ^ a3);
        case 1766:
            return a1 | a0 ^ (a0 | a2);
        case 1767:
            return a1 | a2 & (a0 ^ a3);
        case 1768:
            return a3 & (a1 | a0 ^ a3);
        case 1769:
            return a1 ^ 2047 ^ a3 & (a0 | a1);
        case 1770:
            return a0 ^ 2047 | a1 & a3;
        case 1771:
            return a1 ^ a3 ^ (a0 | a1 & a3);
        case 1772:
            return a1 ^ 2047 ^ (a0 | a1 & a3);
        case 1773:
            return a0 & a1 | a0 ^ a3;
        case 1774:
            return a1 | a0 ^ (a0 | a3);
        case 1775:
            return a1 | 2047 ^ a0 & a3;
        case 1776:
            return a3 & (a1 | a0 ^ a2);
        case 1777:
            return a1 ^ (a1 | a2) ^ a3 & (a0 | a1);
        case 1778:
            return a0 ^ a2 | a1 & a3;
        case 1779:
            return a1 & a3 | a0 ^ a2 & (a1 | a3);
        case 1780:
            return a1 & a3 | a0 ^ a1 ^ a2;
        case 1781:
            return a1 & a3 | a0 ^ a2 & a3;
        case 1782:
            return a1 | a3 & (a0 ^ a2);
        case 1783:
            return a1 | a2 ^ a0 & a3;
        case 1784:
            return a0 ^ (a0 ^ a3 | a1 ^ (a1 | a2));
        case 1785:
            return a1 ^ a3 ^ (a1 | a0 & a2);
        case 1786:
            return a0 ^ (a0 ^ a3 | a2 & (a0 ^ a1));
        case 1787:
            return 2047 ^ a0 & a2 & (a1 ^ a3);
        case 1788:
            return a3 ^ a0 & a2 & (a1 ^ a3);
        case 1789:
            return 2047 ^ a2 & (a0 ^ a1) & (a1 ^ a3);
        case 1790:
            return a1 | 2047 ^ a0 & a2;
        case 1791:
            return a1 | a3 ^ a0 & a2;
        case 1792:
            return a2 ^ a2 & (a3 ^ (a0 | a1));
        case 1793:
            return a2 & (a0 ^ a1 & (a0 ^ a3));
        case 1794:
            return a2 & (a1 ^ a0 & (a1 ^ a3));
        case 1795:
            return a2 & (a2 ^ (a1 ^ a3) & (a0 ^ a3));
        case 1796:
            return a2 & (a0 ^ (a0 ^ a1) & (a0 ^ a3));
        case 1797:
            return a2 & (a0 | a1 ^ a3 ^ 2047);
        case 1798:
            return a2 & (a1 | a0 ^ a2 ^ a3);
        case 1799:
            return a2 & (a0 | a1);
        case 1800:
            return a2 ^ 2047 ^ a3 & (a0 | a1);
        case 1801:
            return a2 ^ a3 ^ (a1 | a0 & a3);
        case 1802:
            return a2 ^ a3 ^ (a0 | a1 & a3);
        case 1803:
            return a0 ^ a2 ^ (a1 ^ 2047 | a0 & a3);
        case 1804:
            return a0 ^ a2 ^ (a0 & a1 | a1 ^ a3);
        case 1805:
            return a2 ^ 2047 ^ (a0 | a1 & a3);
        case 1806:
            return a2 ^ 2047 ^ (a1 | a0 & a3);
        case 1807:
            return a2 ^ a3 & ~(a0 | a1);
        case 1808:
            return a3 & (a0 ^ a1 & (a0 ^ a2));
        case 1809:
            return a1 ^ a2 ^ a3 & (a1 | a0 ^ a2);
        case 1810:
            return a0 ^ (a3 ^ 2047 | a1 & (a0 ^ a2));
        case 1811:
            return a0 ^ a1 & (a2 ^ a0 & a3);
        case 1812:
            return a0 ^ a2 ^ (a0 & a1 | a2 & (a1 ^ a3));
        case 1813:
            return a0 ^ a1 & a3 & (a0 ^ a2);
        case 1814:
            return a1 & a2 | a0 & (a1 ^ a3);
        case 1815:
            return a0 ^ (a0 ^ a2) & (a1 | a3 ^ 2047);
        case 1816:
            return a2 ^ a3 ^ (a1 | a0 & a2);
        case 1817:
            return a1 ^ a3 ^ a2 & (a1 | a0 ^ a3);
        case 1818:
            return a1 ^ (a2 ^ 2047 | a0 & (a1 ^ a3));
        case 1819:
            return a2 ^ (a1 ^ a3) & (a3 ^ a0 & a2);
        case 1820:
            return a1 ^ (a0 | a3) ^ a2 & (a1 | a0 ^ a3);
        case 1821:
            return a0 & a2 | a1 ^ a2 ^ a3;
        case 1822:
            return a1 ^ a2 ^ (a1 | a3 ^ a0 & a2);
        case 1823:
            return a2 ^ 2047 ^ (a1 | a0 & a2);
        case 1824:
            return a3 & (a1 ^ a0 & (a1 ^ a2));
        case 1825:
            return a1 ^ (a3 ^ 2047 | a0 & (a1 ^ a2));
        case 1826:
            return a0 ^ a2 ^ a3 & (a0 | a1 ^ a2);
        case 1827:
            return a1 ^ a0 & (a2 ^ a1 & a3);
        case 1828:
            return a0 ^ a2 ^ (a0 & a3 | a1 ^ a2 & a3);
        case 1829:
            return a0 & a2 | a1 & (a0 ^ a3);
        case 1830:
            return a1 ^ a0 & a3 & (a1 ^ a2);
        case 1831:
            return a0 ^ a2 ^ (a0 | a3 & (a1 ^ a2));
        case 1832:
            return a2 ^ a3 ^ (a0 | a1 & a2);
        case 1833:
            return a0 ^ (a2 ^ 2047 | a1 & (a0 ^ a3));
        case 1834:
            return a0 ^ a3 ^ a2 & (a0 | a1 ^ a3);
        case 1835:
            return a2 ^ (a0 ^ a3) & (a3 ^ a1 & a2);
        case 1836:
            return a0 ^ (a1 | a3) ^ a2 & (a0 | a1 ^ a3);
        case 1837:
            return a0 ^ a2 ^ (a0 | a3 ^ a1 & a2);
        case 1838:
            return a1 & a2 | a0 ^ a2 ^ a3;
        case 1839:
            return a2 ^ 2047 ^ (a0 | a1 & a2);
        case 1840:
            return a0 ^ a3 ^ (a0 & a2 | a1 ^ 2047);
        case 1841:
            return a0 ^ a1 & (a3 ^ a0 & a2);
        case 1842:
            return a1 ^ a0 & (a3 ^ a1 & a2);
        case 1843:
            return a0 ^ a1 | a2 ^ a2 & (a0 ^ a3);
        case 1844:
            return a0 & a3 ^ a1 & (a3 ^ a0 & a2);
        case 1845:
            return a0 ^ 2047 ^ (a0 & a2 | a1 ^ a3);
        case 1846:
            return a1 ^ 2047 ^ (a1 & a2 | a0 ^ a3);
        case 1847:
            return a0 & a2 | a0 ^ a1;
        case 1848:
            return a3 & (a0 ^ a1 | a1 ^ a2 ^ a3);
        case 1849:
            return a3 ^ (a1 ^ a2) & (a2 ^ a0 & a3);
        case 1850:
            return a3 ^ (a0 ^ a2) & (a2 ^ a1 & a3);
        case 1851:
            return a0 ^ a1 | a2 ^ 2047 ^ a0 & a3;
        case 1852:
            return a3 ^ (a2 ^ a1 & a3) & (a0 ^ a1 ^ 2047);
        case 1853:
            return 2047 ^ (a0 ^ a2) & (a2 ^ a1 & a3);
        case 1854:
            return 2047 ^ (a1 ^ a2) & (a2 ^ a0 & a3);
        case 1855:
            return 2047 ^ a3 & (a0 ^ a2) & (a1 ^ a2);
        case 1856:
            return a3 & (a0 ^ (a0 ^ a2) & (a0 ^ a1));
        case 1857:
            return a1 ^ (a0 | a2) ^ a3 & (a1 | a0 ^ a2);
        case 1858:
            return a0 ^ (a1 | a2) ^ a3 & (a0 | a1 ^ a2);
        case 1859:
            return a0 & a2 ^ a1 & (a2 ^ a0 & a3);
        case 1860:
            return a0 ^ (a1 ^ a2 ^ a3) & (a2 ^ a0 & a3);
        case 1861:
            return a0 ^ a3 & (a0 ^ a2) & (a0 ^ a1);
        case 1862:
            return a0 ^ (a0 ^ a1) & (a2 ^ a0 & a3);
        case 1863:
            return a2 ^ a3 & (a0 ^ a2) & (a1 ^ a2);
        case 1864:
            return a0 ^ a3 ^ (a0 & a1 | a1 ^ a2);
        case 1865:
            return a0 ^ a2 ^ 2047 ^ a1 & (a3 ^ a0 & a2);
        case 1866:
            return a0 ^ a3 ^ (a0 & a2 | a1 ^ a2 & a3);
        case 1867:
            return a2 ^ (a3 ^ a1 & a2) & (a0 ^ a1 ^ 2047);
        case 1868:
            return a0 ^ (a1 ^ a2 ^ a3) & (a3 ^ a0 & a2);
        case 1869:
            return a0 ^ a2 ^ (a0 & a2 | a1 ^ a3);
        case 1870:
            return a1 ^ a2 ^ (a1 & a2 | a0 ^ a3);
        case 1871:
            return a0 ^ a1 ^ (a0 & a1 | a2 ^ 2047);
        case 1872:
            return a3 ^ 2047 ^ (a0 | a1 & a2);
        case 1873:
            return a0 ^ a1 & a2 & (a0 ^ a3);
        case 1874:
            return a0 & a3 | a1 & (a0 ^ a2);
        case 1875:
            return 2047 ^ (a0 ^ a3) & (a3 ^ a1 & a2);
        case 1876:
            return a0 ^ a2 & (a0 ^ a1) & (a0 ^ a3);
        case 1877:
            return a0 | a2 & (a1 ^ a3 ^ 2047);
        case 1878:
            return a1 & a2 | a0 ^ a3 ^ 2047;
        case 1879:
            return a0 | a1 & a2;
        case 1880:
            return a3 & (a0 | a1 ^ ~a2);
        case 1881:
            return a0 & a3 | a1 ^ a2 ^ a3;
        case 1882:
            return a0 ^ a3 ^ (a0 | a2 ^ a1 & a3);
        case 1883:
            return a0 ^ 2047 ^ (a1 ^ a2 | a0 & a3);
        case 1884:
            return a0 ^ a3 ^ (a1 ^ a2 | a0 & a3);
        case 1885:
            return a0 | a2 ^ 2047 ^ a1 & a3;
        case 1886:
            return a0 & a3 | a1 ^ a2 ^ 2047;
        case 1887:
            return a0 | a1 ^ a2 ^ (a1 | a3);
        case 1888:
            return a3 ^ 2047 ^ (a1 | a0 & a2);
        case 1889:
            return a1 & a3 | a0 & (a1 ^ a2);
        case 1890:
            return a1 ^ a0 & a2 & (a1 ^ a3);
        case 1891:
            return 2047 ^ (a1 ^ a3) & (a3 ^ a0 & a2);
        case 1892:
            return a0 ^ (a0 ^ a1) & (a3 ^ a0 & a2);
        case 1893:
            return a0 & a2 | a1 ^ a3 ^ 2047;
        case 1894:
            return a1 | a2 ^ a2 & (a0 ^ a3);
        case 1895:
            return a1 | a0 & a2;
        case 1896:
            return a3 & (a1 | a0 ^ a2 ^ a3);
        case 1897:
            return a1 ^ a3 ^ (a1 | a2 ^ a0 & a3);
        case 1898:
            return a1 & a3 | a0 ^ a2 ^ a3;
        case 1899:
            return a1 ^ 2047 ^ (a0 ^ a2 | a1 & a3);
        case 1900:
            return a1 ^ a3 ^ (a0 ^ a2 | a1 & a3);
        case 1901:
            return a1 & a3 | a0 ^ a2 ^ 2047;
        case 1902:
            return a1 | a2 ^ 2047 ^ a0 & a3;
        case 1903:
            return a1 | a0 ^ a2 ^ (a0 | a3);
        case 1904:
            return a3 & (a0 | a1);
        case 1905:
            return a3 ^ 2047 ^ (a1 | a0 & a3);
        case 1906:
            return a3 ^ 2047 ^ (a0 | a1 & a3);
        case 1907:
            return a0 ^ a1 | a0 & a3;
        case 1908:
            return a0 ^ a1 ^ (a0 & a1 | a3 ^ 2047);
        case 1909:
            return a0 | a1 & a3;
        case 1910:
            return a1 | a0 & a3;
        case 1911:
            return a0 | a1 | a3 ^ 2047;
        case 1912:
            return a2 ^ a3 ^ a2 & (a0 | a1);
        case 1913:
            return a0 ^ (a0 ^ a3) & (a1 | a2 ^ 2047);
        case 1914:
            return a0 ^ a3 ^ (a0 | a2 & (a1 ^ a3));
        case 1915:
            return 2047 ^ a2 & (a1 ^ a3) & (a0 ^ a3);
        case 1916:
            return a3 ^ a2 & (a1 ^ a3) & (a0 ^ a3);
        case 1917:
            return a0 | a1 ^ a3 ^ (a1 | a2);
        case 1918:
            return a1 | a0 ^ a3 ^ (a0 | a2);
        case 1919:
            return a0 | a1 | a2 ^ 2047;
        case 1920:
            return a2 & a3;
        case 1921:
            return a1 ^ a2 ^ a1 & a3;
        case 1922:
            return a0 ^ a2 ^ a0 & a3;
        case 1923:
            return a2 & (a3 | a0 ^ a1);
        case 1924:
            return a2 & (a3 | a0 ^ a1 ^ 2047);
        case 1925:
            return a2 & (a0 | a3);
        case 1926:
            return a2 & (a1 | a3);
        case 1927:
            return a2;
        case 1928:
            return 2047 ^ (a2 ^ a3) & (a0 | a1);
        case 1929:
            return a3 ^ (a0 | a1) & (a2 ^ (a1 | a3));
        case 1930:
            return a3 ^ (a0 | a1) & (a2 ^ (a0 | a3));
        case 1931:
            return a0 ^ (a0 ^ a2 | (a1 ^ a3) & (a0 ^ a3));
        case 1932:
            return a2 & a3 | (a1 ^ a3) & (a0 ^ a3);
        case 1933:
            return a3 ^ (a2 ^ a3) & (a0 | a1 ^ a2);
        case 1934:
            return a3 ^ (a2 ^ a3) & (a1 | a0 ^ a2);
        case 1935:
            return a3 ^ (a2 ^ a3) & (a0 | a1);
        case 1936:
            return a2 ^ (a0 | a1) & (a3 ^ (a1 | a2));
        case 1937:
            return a2 & a3 | a0 ^ a0 & a1;
        case 1938:
            return a2 & a3 | (a0 ^ a1) & (a1 ^ a3);
        case 1939:
            return a1 ^ (a1 ^ a2 | a0 & (a2 ^ a3));
        case 1940:
            return a2 & a3 | a0 & (a1 ^ a3);
        case 1941:
            return a0 ^ (a0 ^ a2) & (a2 ^ a1 & (a2 ^ a3));
        case 1942:
            return a0 ^ a2 ^ a0 & (a1 | a2 & a3);
        case 1943:
            return a0 ^ (a0 ^ a2) & (a1 | a0 ^ a3);
        case 1944:
            return a1 ^ a3 ^ a1 & a2;
        case 1945:
            return 2047 ^ a1 & (a2 ^ a3);
        case 1946:
            return a0 ^ a0 & a3 ^ (a2 | a1 ^ 2047);
        case 1947:
            return a2 & a3 | a1 ^ (a0 | a3);
        case 1948:
            return a2 ^ (a2 ^ a3) & (a1 ^ (a0 | a3));
        case 1949:
            return a1 ^ (a0 | a3) ^ a1 & a2;
        case 1950:
            return a3 ^ a1 & (a2 ^ a3);
        case 1951:
            return a2 | a1 ^ 2047;
        case 1952:
            return a2 ^ (a0 | a1) & (a3 ^ (a0 | a2));
        case 1953:
            return a2 & a3 | (a0 ^ a1) & (a0 ^ a3);
        case 1954:
            return a2 & a3 | a0 ^ (a0 | a1);
        case 1955:
            return a0 ^ (a0 ^ a2 | a1 & (a2 ^ a3));
        case 1956:
            return a2 & a3 | a1 & (a0 ^ a3);
        case 1957:
            return a0 ^ a2 ^ (a0 | a1 & (a2 ^ a3));
        case 1958:
            return a0 ^ (a0 ^ a2 | (a2 ^ a3) & (a0 ^ a1));
        case 1959:
            return a1 ^ (a1 ^ a2) & (a0 | a2 & a3);
        case 1960:
            return a0 ^ a3 ^ a0 & a2;
        case 1961:
            return a0 ^ a0 & a2 ^ (a3 | a1 ^ 2047);
        case 1962:
            return 2047 ^ a0 & (a2 ^ a3);
        case 1963:
            return a2 & a3 | a0 ^ (a1 | a3);
        case 1964:
            return a2 ^ (a2 ^ a3) & (a0 ^ (a1 | a3));
        case 1965:
            return a3 ^ a0 & (a2 ^ a3);
        case 1966:
            return a0 ^ a0 & a2 ^ (a1 | a3);
        case 1967:
            return a2 | a0 ^ 2047;
        case 1968:
            return a3 & (a2 | a0 ^ a1);
        case 1969:
            return a2 & a3 | a1 ^ (a0 | a2);
        case 1970:
            return (a1 | a2) ^ a0 & (a2 ^ a3);
        case 1971:
            return a2 & a3 | a0 ^ a1;
        case 1972:
            return a2 ^ (a2 ^ a3) & (a0 ^ a1);
        case 1973:
            return a2 & a3 | a0 ^ a1 & a3;
        case 1974:
            return a2 & a3 | a1 ^ a0 & a3;
        case 1975:
            return a2 | a0 ^ a1;
        case 1976:
            return a0 ^ (a0 ^ a3 | a2 ^ (a1 | a2 & a3));
        case 1977:
            return a1 ^ (a1 ^ a3 | a0 & (a2 ^ a3));
        case 1978:
            return a0 ^ (a0 ^ a3 | a1 & (a0 ^ a2));
        case 1979:
            return 2047 ^ a0 & a1 & (a2 ^ a3);
        case 1980:
            return a3 ^ a0 & a1 & (a2 ^ a3);
        case 1981:
            return 2047 ^ a1 & (a2 ^ (a0 | a2 & a3));
        case 1982:
            return 2047 ^ a0 & (a2 ^ (a1 | a2 & a3));
        case 1983:
            return a2 & a3 | a0 ^ a1 | a1 ^ a3;
        case 1984:
            return a2 & a3 | (a0 ^ a2) & (a1 ^ a2);
        case 1985:
            return a2 & a3 | a0 & (a1 ^ a2);
        case 1986:
            return a2 & a3 | a1 & (a0 ^ a2);
        case 1987:
            return a2 ^ a0 & a1 & (a2 ^ a3);
        case 1988:
            return a2 & a3 | a0 & a1;
        case 1989:
            return a2 ^ a1 & (a2 ^ (a0 | a2 & a3));
        case 1990:
            return a2 ^ a0 & (a2 ^ (a1 | a2 & a3));
        case 1991:
            return (a1 | a2) & (a0 | a2 & (a1 | a3));
        case 1992:
            return a2 ^ a3 ^ (a2 | a0 ^ a1);
        case 1993:
            return a3 ^ (a2 ^ a3) & (a1 ^ (a0 | a2));
        case 1994:
            return a3 ^ (a1 | a2) ^ (a0 | a2 & a3);
        case 1995:
            return a3 ^ (a2 ^ a3) & (a0 ^ a1);
        case 1996:
            return 2047 ^ (a2 ^ a3) & (a0 ^ a1);
        case 1997:
            return a0 ^ (a1 | a2) ^ (a0 | a2 ^ a3);
        case 1998:
            return a1 ^ (a0 | a2) ^ (a1 | a2 ^ a3);
        case 1999:
            return a2 | a0 ^ a1 ^ a3;
        case 2000:
            return a3 & (a0 | a2);
        case 2001:
            return a1 ^ (a0 | a2) ^ a1 & a3;
        case 2002:
            return a2 ^ a0 & (a2 ^ a3);
        case 2003:
            return a2 & a3 | a0 ^ a1 & a2;
        case 2004:
            return a0 ^ (a1 | a3) ^ (a0 | a2 ^ a3);
        case 2005:
            return a0 | a2 & a3;
        case 2006:
            return (a1 | a3) & (a0 | a2);
        case 2007:
            return a0 | a2;
        case 2008:
            return a2 ^ (a2 ^ a3) & (a0 | a1 ^ a3);
        case 2009:
            return a0 ^ (a0 ^ a3) & (a0 ^ a2 | a1 ^ a3);
        case 2010:
            return a0 ^ a3 ^ (a0 | a1 & (a2 ^ a3));
        case 2011:
            return 2047 ^ a1 & (a3 ^ (a0 | a2 & a3));
        case 2012:
            return a3 ^ a1 & (a3 ^ (a0 | a2 & a3));
        case 2013:
            return a0 | 2047 ^ a1 & (a2 ^ a3);
        case 2014:
            return a2 & a3 | a0 ^ a2 | a1 ^ a3;
        case 2015:
            return a0 | a3 ^ a1 & (a2 ^ a3);
        case 2016:
            return a3 & (a1 | a2);
        case 2017:
            return a2 ^ a1 & (a2 ^ a3);
        case 2018:
            return a0 ^ (a1 | a2) ^ a0 & a3;
        case 2019:
            return (a1 | a2) & (a3 | a0 ^ a1);
        case 2020:
            return a1 ^ (a0 | a3) ^ (a1 | a2 ^ a3);
        case 2021:
            return (a1 | a2) & (a0 | a3);
        case 2022:
            return a1 | a2 & a3;
        case 2023:
            return a1 | a2;
        case 2024:
            return a2 ^ (a2 ^ a3) & (a1 | a0 ^ a3);
        case 2025:
            return a0 ^ a3 ^ a0 & (a1 | a2 & a3);
        case 2026:
            return a0 ^ (a0 ^ a3 | (a2 ^ a3) & (a0 ^ a1));
        case 2027:
            return 2047 ^ a0 & (a3 ^ (a1 | a2 & a3));
        case 2028:
            return a3 ^ a0 & (a3 ^ (a1 | a2 & a3));
        case 2029:
            return a2 & a3 | a1 ^ a2 | a0 ^ a3;
        case 2030:
            return a1 | 2047 ^ a0 & (a2 ^ a3);
        case 2031:
            return a1 | a3 ^ a0 & (a2 ^ a3);
        case 2032:
            return a2 ^ (a2 ^ a3) & (a0 | a1);
        case 2033:
            return a0 ^ (a0 ^ a3) & (a1 | a0 ^ a2);
        case 2034:
            return a1 ^ (a1 ^ a3) & (a0 | a2 & a3);
        case 2035:
            return a2 & a3 | a0 ^ a2 | a0 ^ a1;
        case 2036:
            return a0 & a1 | a3 & (a0 | a1 | a2);
        case 2037:
            return a0 | a2 ^ a1 & (a2 ^ a3);
        case 2038:
            return a1 | a2 ^ a0 & (a2 ^ a3);
        case 2039:
            return a0 | a1 | a2 & a3;
        case 2040:
            return a3;
        case 2041:
            return a3 | a1 ^ 2047;
        case 2042:
            return a3 | a0 ^ a2;
        case 2043:
            return a3 | a0 ^ a1;
        case 2044:
            return a3 | a0 ^ a1 ^ 2047;
        case 2045:
            return a0 | a3;
        case 2046:
            return a1 | a3;
        default:
            return 2047;
    }
}
