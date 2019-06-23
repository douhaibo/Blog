package com.blog.service;

import org.springframework.web.multipart.MultipartFile;

/**
 * 文件上传
 * @author DouHaibo
 * @date 2019年6月9日11:58:06
 */
public interface FileService {

    /**
     * 图片上传
     * @param file 图片路径
     * @param path 在项目中的临时文件夹
     * @return 上传后的文件名
     */
    String upload(MultipartFile file, String path);
}
