package com.dz.module.contract;

import com.dz.module.vehicle.Vehicle;

import javax.persistence.*;

@Entity
@Table(name="bankcardofvehicle",catalog = "ky_dzomsdb")
public class BankCardOfVehicle {
    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    private int id;
    @ManyToOne(cascade=CascadeType.ALL)
    private BankCard bankCard;
    @ManyToOne(cascade=CascadeType.ALL)
    private Vehicle vehicle;
    @Column
    private Boolean isDefaultRecive;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public BankCard getBankCard() {
        return bankCard;
    }

    public void setBankCard(BankCard bankCard) {
        this.bankCard = bankCard;
    }

    public Vehicle getVehicle() {
        return vehicle;
    }

    public void setVehicle(Vehicle vehicle) {
        this.vehicle = vehicle;
    }

    public Boolean getIsDefaultRecive() {
        return isDefaultRecive;
    }

    public void setIsDefaultRecive(Boolean defaultRecive) {
        isDefaultRecive = defaultRecive;
    }
}
