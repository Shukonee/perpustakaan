/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author maxeef
 */
public class BukuDetails extends Model<BukuDetails> {
    private int id;
    private int status;
    private String keluhan;
    private int buku_id_fk;
    
    public BukuDetails() {
        this.table = "BukuDetails";
        this.primaryKey = "id";
    }
    
    public BukuDetails(int id, int status, String keluhan, int buku_id_fk) {
        this.table = "BukuDetails";
        this.primaryKey = "id";
        this.id=id;
        this.status = status;
        this.keluhan = keluhan;
        this.buku_id_fk = buku_id_fk;
    }
    
    @Override
    public BukuDetails toModel(ResultSet rs) {
        try {
            return new BukuDetails(
                rs.getInt("id"),
                rs.getInt("status"),
                rs.getString("keluhan"),
                rs.getInt("buku_id_fk")
            );
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
            return null;
        }
    }
    
    public BukuDetails getBukuDetailsById(int id){
        System.out.println("IDDDDDDDDDDDD: "+id);
        return find(String.valueOf(id));
    }
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getKeluhan() {
        return keluhan;
    }

    public void setKeluhan(String keluhan) {
        this.keluhan = keluhan;
    }

    public int getBuku_id_fk() {
        return buku_id_fk;
    }

    public void setBuku_id_fk(int buku_id_fk) {
        this.buku_id_fk = buku_id_fk;
    }
    
    public boolean cekstatus_booking(int buku_idFk) {
        this.where("buku_id_fk = " + buku_idFk);
        ArrayList<BukuDetails> details = this.get();
        for (BukuDetails detail : details) {
            if (detail.getStatus()==1) {
                return true;
            }
            
        }
        return false;
    }
    
    public void tambahBukuDetails(int buku_id,int jumlah){
        System.out.println("Mau Masuk");
        for (int i=0;i<jumlah;i++){
            System.out.println("Dimasukkan");
            BukuDetails bukuDetails = new BukuDetails();
            bukuDetails.setStatus(1);
            bukuDetails.setKeluhan("Tidak ada");
            bukuDetails.setBuku_id_fk(buku_id);
            System.out.println("Inserting BukuDetails for Buku ID: " + buku_id+this.status);
            bukuDetails.insert();
        }
    }
}
