package com.dz.kaiying.repository.hiber;

import java.lang.reflect.ParameterizedType;

/**
 * Created by huang on 2017/4/24.
 */
public class TestTypeInference {
    public static <T> T get() {
        return (T) "x";
    }

    public static void main(String[] args) {
        Child<String> child = new Child();
        System.out.println(child.getEntityClass());
    }

    public static String getX() {
        return "x";
    }
}

class Base<T> {

    private Class<T> entityClass;

    //代码块,也可将其放置到构造子中
    {
        entityClass =(Class<T>)((ParameterizedType)getClass().getGenericSuperclass()).getActualTypeArguments()[0];

    }

    //泛型的实际类型参数的类全名
    public String getEntityName(){

        return entityClass.getName();
    }

    //泛型的实际类型参数的类名
    public String getEntitySimpleName(){

        return entityClass.getSimpleName();
    }

    //泛型的实际类型参数的Class
    public Class<T> getEntityClass() {
        return entityClass;
    }

}

 class Child<T> extends Base<T>{

}