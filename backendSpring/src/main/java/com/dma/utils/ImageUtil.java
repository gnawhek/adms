package com.dma.utils;

import lombok.extern.slf4j.Slf4j;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.*;
import java.net.URL;
import java.net.URLConnection;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.*;

@Slf4j
public class ImageUtil {

    private ImageUtil() {
    }

    public static byte[] imageDataToBytes(String dataString, String formatName) {
        byte[] bytes = null;
        try {
            byte[] imageBytes = javax.xml.bind.DatatypeConverter.parseBase64Binary(dataString);
            BufferedImage image = ImageIO.read(new ByteArrayInputStream(imageBytes));
            ByteArrayOutputStream out = new ByteArrayOutputStream();
            ImageIO.write(image, formatName, out);
            bytes = out.toByteArray();
        } catch (Exception e) {
            System.out.println(e.getStackTrace());
        }
        return bytes;
    }

    public static void saveImageMemory(String dataString, String formatName, String filename) {
        try {
            ByteArrayOutputStream out = new ByteArrayOutputStream();
            saveImageMemory(dataString, formatName, out);
            File outputfile = new File(filename);
            FileOutputStream fos = new FileOutputStream(outputfile);
            fos.write(out.toByteArray());
            fos.close();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static void saveImageMemory(String dataString, String formatName, OutputStream out) {
        try {
            byte[] imageBytes = javax.xml.bind.DatatypeConverter.parseBase64Binary(dataString);
            BufferedImage image = ImageIO.read(new ByteArrayInputStream(imageBytes));
            ImageIO.write(image, formatName, out);
        } catch (Exception e) {
            System.out.println(e.getStackTrace());
        }
    }

    public static String saveImageFile(String dataString, String formatName, String filename) {

        try {
            byte[] imageBytes = javax.xml.bind.DatatypeConverter.parseBase64Binary(dataString);
            BufferedImage image = ImageIO.read(new ByteArrayInputStream(imageBytes));
            // write the image to a file
            File outputfile = new File(filename);
            ImageIO.write(image, formatName, outputfile);
            return outputfile.getAbsoluteFile().toString();

        } catch (Exception e) {
            System.out.println(e.getStackTrace());
        }

        return null;
    }

    public static void saveImage(InputStream imageStream, String filename, String extension) {
        InputStream inStream = imageStream;

        try {
            String dataString = convertStreamToString(inStream);

            byte[] imageBytes = javax.xml.bind.DatatypeConverter.parseBase64Binary(dataString);
            BufferedImage image = ImageIO.read(new ByteArrayInputStream(imageBytes));
            // write the image to a file
            File outputfile = new File(filename);
            ImageIO.write(image, extension, outputfile);

        } catch (Exception e) {
            System.out.println(e.getStackTrace());
        }
    }

    public static String saveImage(String dataString, String filename, String extension) {

        try {
            byte[] imageBytes = javax.xml.bind.DatatypeConverter.parseBase64Binary(dataString);
            BufferedImage image = ImageIO.read(new ByteArrayInputStream(imageBytes));
            // write the image to a file
            File outputfile = new File(filename);
            ImageIO.write(image, extension, outputfile);
            return outputfile.getAbsoluteFile().toString();

        } catch (Exception e) {
            System.out.println(e.getStackTrace());
        }

        return null;
    }

    public static String convertStreamToString(String filename) {
        try {
            Path path = Paths.get(filename);
            byte[] data = Files.readAllBytes(path);
            return javax.xml.bind.DatatypeConverter.printBase64Binary(data);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static String convertStreamToString(File file) throws FileNotFoundException {
        InputStream inputStream = new FileInputStream(file);
        return convertStreamToString(inputStream);
    }

    @SuppressWarnings("resource")
    public static String convertStreamToString(InputStream inputStream) throws FileNotFoundException {
        java.util.Scanner s = new java.util.Scanner(inputStream).useDelimiter("\\A");
        return s.hasNext() ? s.next() : "";
    }

    public static byte[] imageBase64ToBytes(Object imageBase64) {
        byte[] bytes = null;
        if (imageBase64 instanceof String) {
            String imageData = imageBase64.toString();
            if (imageData.startsWith("data:image")) {
                String[] imageArray = imageData.split(";base64,");
                String formatName = imageArray[0].split("/")[1];
                String dataString = imageArray[1];
                bytes = ImageUtil.imageDataToBytes(dataString, formatName);
            }
        }
        return bytes;
    }

    public static boolean saveImage(String pathname, byte[] bytes) {
        if (bytes != null) {
            try {
                File outputfile = new File(pathname);
                FileOutputStream fos = new FileOutputStream(outputfile);
                fos.write(bytes);
                fos.close();
                return true;
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return false;
    }
}