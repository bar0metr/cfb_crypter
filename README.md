# CFB Crypter
In English:
CFB Crypter - Program for file encryption method Cipher Feedback Mode, CFB) - an option of using a symmetric block cipher, in which he composed for the encryption of the next block of plaintext modulo 2 recoding (block cipher) the result of the encryption of the previous block. Strong enough algorithm, 128 bit. Written on Lazarus (FPC).
The program can encrypt and decrypt files it has encrypted.
From the parameters:
1) initialization vector (sinhroposylka) (must be unique and up to 16 characters!).
2) encryption key (do not forget it! Otherwise lost files!).

На русском:
CFB Crypter - программа для шифрования файлов способом Cipher Feedback Mode, CFB) - один из вариантов использования симметричного блочного шифра, при котором для шифрования следующего блока открытого текста он складывается по модулю 2 с перешифрованным (блочным шифром) результатом шифрования предыдущего блока. Достаточно сильный алгоритм, 128бит. 
Программа умеет зашифровывать и расшифровывать уже зашифрованные ей файлы. 
Из параметров:
1) вектор инициализации (синхропосылка) (ДОЛЖЕН БЫТЬ УНИКАЛЬНЫМ И СОСТОЯТЬ ИЗ 16 СИМВОЛОВ!).
2) ключ шифрования (не забудьте его! в противном случае ПОТЕРЯЕТЕ ФАЙЛ!).

