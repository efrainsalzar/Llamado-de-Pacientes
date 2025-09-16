// src/utils/legacyPassword.ts

// Mapa igual al de PHP (Utiles::encriptar / desencriptar)
const charToCode: Record<string, string> = {
  "/": "X46", "|": "141",

  "0": "X56", "1": "X66", "2": "X76", "3": "X86",
  "4": "X96", "5": "X07", "6": "X17", "7": "X27",
  "8": "X37", "9": "X47",

  "a": "411", "b": "511", "c": "611", "d": "711",
  "e": "811", "f": "911", "g": "021", "h": "121",
  "i": "221", "j": "321", "k": "421", "l": "521",
  "m": "621", "n": "721", "ñ": "852", "o": "821",
  "p": "921", "q": "031", "r": "131", "s": "231",
  "t": "331", "u": "431", "v": "531", "w": "631",
  "x": "731", "y": "831", "z": "931",

  "A": "X28", "B": "X38", "C": "X48", "D": "X58",
  "E": "X68", "F": "X78", "G": "X88", "H": "X98",
  "I": "X09", "J": "X19", "K": "X29", "L": "X39",
  "M": "X49", "N": "X59", "Ñ": "622", "O": "X69",
  "P": "X79", "Q": "X89", "R": "X99", "S": "001",
  "T": "101", "U": "201", "V": "301", "W": "401",
  "X": "501", "Y": "601", "Z": "701",
};

const codeToChar: Record<string, string> = Object.fromEntries(
  Object.entries(charToCode).map(([k, v]) => [v, k])
);

/**
 * Codifica exactamente como PHP Utiles::encriptar
 * - Sustitución por el mapa
 * - Prepend (invierte el orden)
 */
export function encodeLegacyPassword(plain: string): string {
  let out = "";
  for (const ch of plain) {
    const code = charToCode[ch];
    if (!code) throw new Error(`Caracter no soportado en legacy: '${ch}'`);
    out = code + out; // prepend para invertir
  }
  return out;
}

/**
 * Decodifica exactamente como PHP Utiles::desencriptar
 * - Lee en chunks de 3 desde el final
 */
export function decodeLegacyPassword(encoded: string): string {
  if (encoded.length % 3 !== 0) {
    throw new Error("Cadena legacy inválida: longitud no múltiplo de 3.");
  }
  let out = "";
  for (let i = encoded.length - 3; i >= 0; i -= 3) {
    const chunk = encoded.slice(i, i + 3);
    const ch = codeToChar[chunk];
    if (!ch) throw new Error(`Chunk desconocido en legacy: '${chunk}'`);
    out += ch;
  }
  return out;
}

/** Heurística simple para detectar formato legacy */
export function isLegacyEncoded(s: string): boolean {
  return s.length % 3 === 0 && /^(?:X\d{2}|\d{3})+$/.test(s);
}


/**
 * import { encodeLegacyPassword, decodeLegacyPassword } from "./utils/legacyPassword";

console.log(encodeLegacyPassword("123456"));
// -> "X17X07X96X86X76X66"

console.log(decodeLegacyPassword("X17X07X96X86X76X66"));
 * 
 */