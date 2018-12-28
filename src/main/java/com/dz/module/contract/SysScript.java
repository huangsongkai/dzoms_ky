package com.dz.module.contract;

import javax.persistence.*;

import java.util.HashSet;

import static javax.persistence.GenerationType.IDENTITY;

/**
 * Created by Wang on 2018/11/28.
 */
@Entity
@Table(catalog = "ky_dzomsdb",name = "sys_script")
@Deprecated
public class SysScript {

    @Id
    @GeneratedValue(strategy = IDENTITY)
    @Column(name = "id", unique = true, nullable = false)
    private int id;

    private String type;
    private String name;
    private String version;
    private String script;

    @Column(name = "isActive")
    private boolean isActive;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getVersion() {
        return version;
    }

    public void setVersion(String version) {
        this.version = version;
    }

    public String getScript() {
        return script;
    }

    public void setScript(String script) {
        this.script = script;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }

    public static HashSet<String> scriptSignals = new HashSet<>();
}
