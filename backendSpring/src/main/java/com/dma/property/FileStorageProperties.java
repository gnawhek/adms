package com.dma.property;

import java.nio.file.Files;
import java.nio.file.Paths;

import com.dma.utils.FileUtil;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;

@Component
@Getter
@Setter
@ConfigurationProperties(prefix = "file")
public class FileStorageProperties {
    private String uploadDir;
    @Value("${file.access-url:/external/**}")
    private String accessUrl;

    public String getUploadDir() {
        String dir = FileUtil.combine(FileUtil.getCurrentDir(), "uploads");
        if (uploadDir != null) {
            dir = uploadDir;
        }

        if (!Files.exists(Paths.get(dir))) {
            FileUtil.mkDirs(dir);
        }
        return dir;
    }

    public void setUploadDir(String uploadDir) {
        this.uploadDir = uploadDir;
    }
}
