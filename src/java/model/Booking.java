/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.time.LocalDate;
/**
 *
 * @author maxeef
 */
public class Booking extends Model<Booking>{
    private int booking_id;
    private LocalDate booking_date;
    private LocalDate expired_date;
    private int member_id_fk;
    private int bukuDetails_id_fk;
    
    public Booking(){
        this.table = "Booking";
        this.primaryKey = "booking_id";
    }

    public Booking(int booking_id, LocalDate booking_date, LocalDate expired_date, int member_id_fk, int bukuDetails_id_fk) {
        this.table = "Booking";
        this.primaryKey = "booking_id";
        this.booking_id = booking_id;
        this.booking_date = booking_date;
        this.expired_date = expired_date;
        this.member_id_fk = member_id_fk;
        this.bukuDetails_id_fk = bukuDetails_id_fk;
    }
    
    @Override
    public Booking toModel(ResultSet rs) {
        try {
            return new Booking(
                rs.getInt("booking_id"),
                rs.getDate("booking_date").toLocalDate(),
                rs.getDate("expired_date").toLocalDate(),
                rs.getInt("member_id_fk"),
                rs.getInt("bukuDetails_id_fk")
            );
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
            return null;
        }
    }

    public int getBooking_id() {
        return booking_id;
    }

    public void setBooking_id(int booking_id) {
        this.booking_id = booking_id;
    }

    public LocalDate getBooking_date() {
        return booking_date;
    }

    public void setBooking_date(LocalDate booking_date) {
        this.booking_date = booking_date;
    }

    public LocalDate getExpired_date() {
        return expired_date;
    }

    public void setExpired_date(LocalDate expired_date) {
        this.expired_date = expired_date;
    }

    public int getMember_id_fk() {
        return member_id_fk;
    }

    public void setMember_id_fk(int member_id_fk) {
        this.member_id_fk = member_id_fk;
    }

    public int getBukuDetails_id_fk() {
        return bukuDetails_id_fk;
    }

    public void setBukuDetails_id_fk(int bukuDetails_id_fk) {
        this.bukuDetails_id_fk = bukuDetails_id_fk;
    }
    
}
