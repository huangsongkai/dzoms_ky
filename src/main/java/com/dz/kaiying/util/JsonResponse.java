package com.dz.kaiying.util;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Created by song on 2016/12/25.
 */
public class JsonResponse {
    private final Logger logger = LoggerFactory.getLogger(JsonResponse.class);

    Result result;
    String jsonrpc;
    int id;
    public static String SEPARATOR = "\\n";

    public Result getResult() {
        return result;
    }

    public void setResult(Result result) {
        this.result = result;
    }

    public String getJsonrpc() {
        return jsonrpc;
    }

    public void setJsonrpc(String jsonrpc) {
        this.jsonrpc = jsonrpc;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public class Result{
        private String status; // 1表示正确，-1表示错误
        private String message; // 详细信息

        public String getStatus() {
            return status;
        }

        public void setStatus(String status) {
            this.status = status;
        }

        public String getMessage() {
            return message;
        }

        public void setMessage(String message) {
            this.message = message;
        }
    }

//    public Util.Result toResult(){
//        util.Result result = new util.Result();
//        result.setStatus();
//        result.setMessage(getResult().getMessage());
//        logger.info(result.getMessage());
//        return result;
//    }
}
