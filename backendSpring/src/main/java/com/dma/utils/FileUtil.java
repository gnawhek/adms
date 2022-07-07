package com.dma.utils;

import java.awt.image.BufferedImage;
import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.imageio.ImageIO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class FileUtil {

    public static final String separator = "/";
	private static boolean isWindows = File.pathSeparator.equals(";");
	
	private FileUtil() {}

    public static boolean isWindows() {
        return isWindows;
    }

	public static String readFile(String filename) {
		File f = new File(filename);
		try {
			byte[] bytes = Files.readAllBytes(f.toPath());
			return new String(bytes, "UTF-8");
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return "";
	}

    public static String combine(Object... paths) {
        File file = new File(String.valueOf(paths[0]));

        for (int i = 1; i < paths.length; i++) {
            file = new File(file, String.valueOf(paths[i]));
        }

        String path = file.getPath();
        path = replaceSeparator(path);
        return path;
    }

	public static String getExtension(String fileName) {
		char ch;
		int len;
		if (fileName == null || (len = fileName.length()) == 0 || (ch = fileName.charAt(len - 1)) == '/' || ch == '\\' || //in the case of a directory
				ch == '.') //in the case of . or ..
		{
			return "";
		}
		int dotInd = fileName.lastIndexOf('.'), sepInd = Math.max(fileName.lastIndexOf('/'), fileName.lastIndexOf('\\'));
		if (dotInd <= sepInd) {
			return "";
		} else {
			return fileName.substring(dotInd + 1).toLowerCase();
		}
	}

	public static String getFile(String fileName) {
		File f = new File(fileName);
		if (f.exists()) {
			try {
				byte[] bytes = Files.readAllBytes(f.toPath());
				return new String(bytes, "UTF-8");
			} catch (FileNotFoundException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			return "";
		} else {
			StringBuilder result = new StringBuilder("");
			BufferedReader br = null;

			try {
				String sCurrentLine;

				URL url = Thread.currentThread().getContextClassLoader().getResource(fileName);
				URLConnection conn = url.openConnection();
				InputStream in = conn.getInputStream();

				br = new BufferedReader(new InputStreamReader(in));
				while ((sCurrentLine = br.readLine()) != null) {
					result.append(sCurrentLine).append("\n");
				}
			} catch (IOException e) {
				e.printStackTrace();
			} finally {
				try {
					if (br != null) {
						br.close();
					}
				} catch (IOException ex) {
					ex.printStackTrace();
				}
			}

			return result.toString();
		}
	}

    public static String replaceSeparator(String path) {
        return path != null && isWindows() ? path.replace("\\", separator) : path;
    }
   
    public static File mkDirs(String path) {

        File file = new File(path);

        if (file.isFile()) {
            path = replaceSeparator(file.getParent());
            file = file.getParentFile();
        }

        if (!file.exists()) {
            if (file.mkdirs()) {
                System.out.println("디렉토리를 생성했습니다. :" + path);
				return file;
            } else {
                System.out.println("디렉토리를 생성하지 못했습니다. :" + path);
            }
        }
        return file;
    }

    public static String generateUUID() {
        return UUID.randomUUID().toString();
	}
	
	public static boolean existFile(String pathname) {
		try {
			File file = new File(pathname);
			return file != null;
		} catch (Exception e) {
		}

		return false;
	}

    public static boolean deleteFile(String pathname) {
		try {
			File file = new File(pathname);
			if (file.delete()) {
				return true;
			}
		} catch (Exception e) {
			log.info("deleteFile error: {}", e.getMessage());
		}

		return false;
	}

    public static void DeleteOldFiles(String directory) {

        if(directory == null)
            return;

        Calendar cal = Calendar.getInstance();    // Calendar 객체 생성
        long todayMil = cal.getTimeInMillis();    // 현재 시간(밀리 세컨드)
        long oneDayMil = 24 * 60 * 60 * 1000;    // 일 단위

        Calendar fileCal = Calendar.getInstance();
        Date fileDate = null;

        File path = new File(directory);
        File[] list = path.listFiles();         // 파일 리스트 가져오기

        for (int j = 0; j < list.length; j++) {

            // 파일의 마지막 수정시간 가져오기
            fileDate = new Date(list[j].lastModified());

            // 현재시간과 파일 수정시간 시간차 계산(단위 : 밀리 세컨드)
            fileCal.setTime(fileDate);
            long diffMil = todayMil - fileCal.getTimeInMillis();

            // 시간으로 계산
            int diffDay = (int)(diffMil / (oneDayMil / 24));

            // 1시간이 지난 파일 삭제
            if (diffDay >= 1 && list[j].exists()) {
                list[j].delete();
//                System.out.println(list[j].getName() + " 파일을 삭제했습니다.");
            }
        }
    }

    public static List<String> Find(String path, String prefixFileName) {
		File scannedDir = new File(path);
		List<String> files = new ArrayList<String>();
		for (File file : scannedDir.listFiles()) {
			files.addAll(Find(file, prefixFileName));
		}
		return files;
	}

	private static List<String> Find(File file, String prefixFileName) {
		List<String> files = new ArrayList<String>();
		String resource = file.getPath();
		if (file.isDirectory()) {
			for (File child : file.listFiles()) {
				files.addAll(Find(child, prefixFileName));
			}
		} else if (resource.indexOf(prefixFileName) != -1) {
			files.add(resource);
		}
		return files;
	}

	public static String getCurrentDir() {
		return System.getProperty("user.dir");
	}

	public static Path getCurrentPath() {
		return Paths.get(getCurrentDir());
	}

}