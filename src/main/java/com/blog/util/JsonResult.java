package com.blog.util;

import java.util.Collection;

/** 请求JSON数据的模板
 *  @author ljt
 *  @date 2019/1/11
 *  @version 1.0
*/
public class JsonResult  {
    /**
     * 请求条数
     */
    private Integer totalCount;
    /**
     * 请求状态 success 代表成功 fail 代表失败
     */
    private String request;
    /**
     * 请求状态码
     */
    private Integer status;
    /**
     * 结果信息
     */
    private String message;
    /**
     * 数据集合
     */
    private Collection<?> data;


    private JsonResult(Builder builder) {
        setTotalCount(builder.totalCount);
        setRequest(builder.request);
        setStatus(builder.status);
        setMessage(builder.message);
        setData(builder.data);
    }

    public static Builder newBuilder() {
        return new Builder();
    }

    public static Builder newBuilder(JsonResult copy) {
        Builder builder = new Builder();
        builder.totalCount = copy.getTotalCount();
        builder.request = copy.getRequest();
        builder.status = copy.getStatus();
        builder.message = copy.getMessage();
        builder.data = copy.getData();
        return builder;
    }

    public Integer getTotalCount() {
        return totalCount;
    }

    public void setTotalCount(Integer totalCount) {
        this.totalCount = totalCount;
    }

    public String getRequest() {
        return request;
    }

    public void setRequest(String request) {
        this.request = request;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Collection<?> getData() {
        return data;
    }

    public void setData(Collection<?> data) {
        this.data = data;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "JsonResult{" +
                "totalCount=" + totalCount +
                ", request='" + request + '\'' +
                ", status=" + status +
                ", message='" + message + '\'' +
                ", data=" + data +
                '}';
    }

    /**
     * 通用的success类型
     * @return ok
     */
    public static  JsonResult success(Collection<?> data,Integer totalCount) {
        JsonResult success = new JsonResult();
        success.setRequest("success");
        success.setStatus(200);
        success.setData(data);
        if (data.size() == 0) {
            success.setMessage("没有数据！");
        } else {
            success.setMessage("请求成功！");
        }
        success.setTotalCount(totalCount);
        return success;
    }

    /**
     * 通用的fial类型
     * @return fail
     */
    public static JsonResult fail(Integer status,String message) {
        JsonResult fail = new JsonResult();
        fail.setRequest("fail");
        fail.setStatus(status);
        fail.setMessage(message);
        return fail;
    }

    /**
     * 通用success 类型 ，不带数据，只是提供提示信息
     * @param message 提示信息
     * @param status 响应状态码
     * @return JsonResult
     */
    public static JsonResult successForMessage(String message,Integer status) {
        JsonResult success = new JsonResult();
        success.setRequest("success");
        success.setStatus(status);
        success.setMessage(message);
        return success;
    }


    public static final class Builder {
        private Integer totalCount;
        private String request;
        private Integer status;
        private String message;
        private Collection<?> data;

        private Builder() {
        }

        public Builder totalCount(Integer val) {
            totalCount = val;
            return this;
        }

        public Builder request(String val) {
            request = val;
            return this;
        }

        public Builder status(Integer val) {
            status = val;
            return this;
        }

        public Builder message(String val) {
            message = val;
            return this;
        }

        public Builder data(Collection<?> val) {
            data = val;
            return this;
        }

        public JsonResult build() {
            return new JsonResult(this);
        }
    }
    private JsonResult() {
    }
}
