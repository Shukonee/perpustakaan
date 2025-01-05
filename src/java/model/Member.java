/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import java.time.LocalDate;
import java.sql.ResultSet;
import java.sql.SQLException;
/**
 *
 * @author alfin
 */
public class Member extends Model<Member>{
    private int member_id,account_id_fk;
    private String nama_depan, nama_belakang;
    private LocalDate tanggal_lahir;
    
    public Member(){
        this.table = "member";
        this.primaryKey = "member_id";
    }

    public Member(int member_id, int account_id_fk, String nama_depan, String nama_belakang, LocalDate tanggal_lahir) {
        this.table = "member";
        this.primaryKey = "member_id";
        this.member_id = member_id;
        this.account_id_fk = account_id_fk;
        this.nama_depan = nama_depan;
        this.nama_belakang = nama_belakang;
        this.tanggal_lahir = tanggal_lahir;
    }
    
    @Override
    public Member toModel(ResultSet rs){
        try{
            return new Member(
                rs.getInt("buku_id"),
                rs.getInt("account_id_fk"),
                rs.getString("nama_depan"),
                rs.getString("nama_belakang"),
                rs.getDate("tgl_terbit").toLocalDate()
            );
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
            return null;
        }
    }

    public int getMember_id() {
        return member_id;
    }

    public void setMember_id(int member_id) {
        this.member_id = member_id;
    }

    public int getAccount_id_fk() {
        return account_id_fk;
    }

    public void setAccount_id_fk(int account_id_fk) {
        this.account_id_fk = account_id_fk;
    }

    public String getNama_depan() {
        return nama_depan;
    }

    public void setNama_depan(String nama_depan) {
        this.nama_depan = nama_depan;
    }

    public String getNama_belakang() {
        return nama_belakang;
    }

    public void setNama_belakang(String nama_belakang) {
        this.nama_belakang = nama_belakang;
    }

    public LocalDate getTanggal_lahir() {
        return tanggal_lahir;
    }

    public void setTanggal_lahir(LocalDate tanggal_lahir) {
        this.tanggal_lahir = tanggal_lahir;
    }
    
    
    
}
