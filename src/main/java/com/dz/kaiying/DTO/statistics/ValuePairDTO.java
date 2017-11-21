package com.dz.kaiying.DTO.statistics;

/**
 * Created by song on 2017/7/7.
 */
public class ValuePairDTO<S,T> {
    S name;
    T value;

    public ValuePairDTO(S name, T value) {
        this.name = name;
        this.value = value;
    }

    public S getName() {
        return name;
    }

    public void setName(S name) {
        this.name = name;
    }

    public T getValue() {
        return value;
    }

    public void setValue(T value) {
        this.value = value;
    }
}
