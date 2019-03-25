package com.dz.common.global;

import java.security.SecureRandom;
import java.util.Arrays;
import java.util.Base64;

import static com.kosprov.jargon2.api.Jargon2.*;

public class GenerateKeyHash {
    private static GenerateKeyHash instance;
    public static GenerateKeyHash getInstance() {
        if (instance == null) {
            synchronized (GenerateKeyHash.class){
                if (instance == null) {
                    instance = new GenerateKeyHash();
                }
            }
        }
        return instance;
    }

    private Hasher hasher;     // The hasher instance
    private Verifier verifier; // The verifier instance
    private SecureRandom secureRandom = new SecureRandom();
    private Base64.Encoder encoder = Base64.getEncoder();
    private Base64.Decoder decoder = Base64.getDecoder();

    private GenerateKeyHash(){
        Type type = Type.ARGON2d;
        int memoryCost = 65536;
        int timeCost = 3;
        int parallelism = 4;
        int hashLength = 16;
        // Configure the hasher
        hasher = jargon2Hasher()
                .type(type)
                .memoryCost(memoryCost)
                .timeCost(timeCost)
                .parallelism(parallelism)
                .hashLength(hashLength);

        // Configure the verifier with the same settings as the hasher
        verifier = jargon2Verifier()
                .type(type)
                .memoryCost(memoryCost)
                .timeCost(timeCost)
                .parallelism(parallelism);
    }

    public byte[] generateSalt(){
        return secureRandom.generateSeed(16);
    }

    public String generateSaltAsString(){
        return encoder.encodeToString(generateSalt());
    }

    public String encodedHash(String salt, String password){
        byte[] saltBytes = decoder.decode(salt);
        ByteArray passBytes = toByteArray(password);
        return hasher.salt(saltBytes).password(passBytes).encodedHash();
    }

    public boolean verify(String hash, String salt, String password){
        byte[] saltBytes = decoder.decode(salt);
        ByteArray passBytes = toByteArray(password);
        return verifier.salt(saltBytes).hash(hash).password(passBytes).verifyEncoded();
    }

    public static void main(String[] args){
        GenerateKeyHash hasher = GenerateKeyHash.getInstance();

//        for (int i = 0; i < 10; i++) {
//            System.out.println(hasher.generateSaltAsString());
//        }
//        String salt = hasher.generateSaltAsString();
//        System.out.println(salt);
        String password = "2tongiloveyou";
//        String hash = hasher.encodedHash(salt,password);
//        System.out.println(hash);

        String salt = "aAc7qn4T5U2T5coZwW3tfA==";
        String hash = "$argon2d$v=19$m=65536,t=3,p=4$aAc7qn4T5U2T5coZwW3tfA$IUrF9nB0IPJVt/fPQiJKGw";

        System.out.println(hasher.verify(hash,salt,password));

    }



    static void simpleTest(){
        byte[] password = "this is a password".getBytes();

        // Configure the hasher
        Hasher hasher = jargon2Hasher()
                .type(Type.ARGON2d) // Data-dependent hashing
                .memoryCost(65536)  // 64MB memory cost
                .timeCost(3)        // 3 passes through memory
                .parallelism(4)     // use 4 lanes and 4 threads
                .saltLength(16)     // 16 random bytes salt
                .hashLength(16);    // 16 bytes output hash



        // Set the password and calculate the encoded hash
        String encodedHash = hasher.password(password).encodedHash();

        System.out.printf("Hash: %s%n", encodedHash);

        // Just get a hold on the verifier. No special configuration needed
        Verifier verifier = jargon2Verifier();

        // Set the encoded hash, the password and verify
        boolean matches = verifier.hash(encodedHash).password(password).verifyEncoded();

        System.out.printf("Matches: %s%n", matches);
    }

    static void withSalt(){
        byte[] salt = "this is a salt".getBytes();
        byte[] password = "this is a password".getBytes();

        Type type = Type.ARGON2d;
        int memoryCost = 65536;
        int timeCost = 3;
        int parallelism = 4;
        int hashLength = 16;

        // Configure the hasher
        Hasher hasher = jargon2Hasher()
                .type(type)
                .memoryCost(memoryCost)
                .timeCost(timeCost)
                .parallelism(parallelism)
                .hashLength(hashLength);

        // Configure the verifier with the same settings as the hasher
        Verifier verifier = jargon2Verifier()
                .type(type)
                .memoryCost(memoryCost)
                .timeCost(timeCost)
                .parallelism(parallelism);

        // Set the salt and password to calculate the raw hash
        byte[] rawHash = hasher.salt(salt).password(password).rawHash();

        System.out.printf("Hash: %s%n", Arrays.toString(rawHash));

        // Set the raw hash, salt and password and verify
        boolean matches = verifier.hash(rawHash).salt(salt).password(password).verifyRaw();

        System.out.printf("Matches: %s%n", matches);
    }
}
