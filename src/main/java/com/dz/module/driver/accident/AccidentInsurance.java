package com.dz.module.driver.accident;

import javax.persistence.*;
import java.util.List;

/**
 * @author doggy
 *         Created on 16-3-23.
 */
@Entity
@Table(name = "accidentinsurance",catalog = "ky_dzomsdb")
public class AccidentInsurance {
    @Id
    @GeneratedValue
    private int id;
    //事故id
    private int accId;
    //商业险
    //盗抢险
    private boolean com_thief;
    //车损险
    private boolean com_car;
    //车上人员险
    private boolean com_people;
    //其他
    private boolean com_other;
    //交强险
    //医疗险
    private boolean tra_doc;
    //车损险
    private boolean tra_car;
    //伤残险
    private boolean tra_people;
    //其他
    private boolean tra_other;
    //事故教训
    private String acc_learn;
    @ElementCollection(fetch = FetchType.EAGER)
    @CollectionTable(name = "accidentinsurance_files",catalog = "ky_dzomsdb")
    private List<String> filePaths;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getAccId() {
        return accId;
    }

    public void setAccId(int accId) {
        this.accId = accId;
    }

    public boolean getCom_thief() {
        return com_thief;
    }

    public void setCom_thief(boolean com_thief) {
        this.com_thief = com_thief;
    }

    public boolean getCom_car() {
        return com_car;
    }

    public void setCom_car(boolean com_car) {
        this.com_car = com_car;
    }

    public boolean getCom_people() {
        return com_people;
    }

    public void setCom_people(boolean com_people) {
        this.com_people = com_people;
    }

    public boolean getCom_other() {
        return com_other;
    }

    public void setCom_other(boolean com_other) {
        this.com_other = com_other;
    }

    public boolean getTra_doc() {
        return tra_doc;
    }

    public void setTra_doc(boolean tra_doc) {
        this.tra_doc = tra_doc;
    }

    public boolean getTra_car() {
        return tra_car;
    }

    public void setTra_car(boolean tra_car) {
        this.tra_car = tra_car;
    }

    public boolean getTra_people() {
        return tra_people;
    }

    public void setTra_people(boolean tra_people) {
        this.tra_people = tra_people;
    }

    public boolean getTra_other() {
        return tra_other;
    }

    public void setTra_other(boolean tra_other) {
        this.tra_other = tra_other;
    }

    public String getAcc_learn() {
        return acc_learn;
    }

    public void setAcc_learn(String acc_learn) {
        this.acc_learn = acc_learn;
    }

    public List<String> getFilePaths() {
        return filePaths;
    }

    public void setFilePaths(List<String> filePaths) {
        this.filePaths = filePaths;
    }

    @Override
    public String toString() {
        return "AccidentInsurance{" +
                "id=" + id +
                ", accId=" + accId +
                ", com_thief=" + com_thief +
                ", com_car=" + com_car +
                ", com_people=" + com_people +
                ", com_other=" + com_other +
                ", tra_doc=" + tra_doc +
                ", tra_car=" + tra_car +
                ", tra_people=" + tra_people +
                ", tra_other=" + tra_other +
                ", acc_learn='" + acc_learn + '\'' +
                ", filePaths=" + filePaths +
                '}';
    }
}
