/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.time.LocalDate;
import model.Member;
import model.Member;
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
    private Member member;
    private BukuDetails bukuDetail;
    
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
            Booking booking = new Booking(
                rs.getInt("booking_id"),
                rs.getDate("booking_date").toLocalDate(),
                rs.getDate("expired_date").toLocalDate(),
                rs.getInt("member_id_fk"),
                rs.getInt("bukuDetails_id_fk")
            );
            
            try {
                Member member = new Member();
                System.out.println("Member ID FK: "+this.member_id_fk);
                booking.setMember(member.find(String.valueOf(booking.getMember_id_fk())));
            } catch (Exception e) {
                System.out.println("Error loading member: " + e.getMessage());
            }
            BukuDetails bukuDetail = new BukuDetails();
            System.out.println("BUKUDETAILS ID FK: "+bukuDetails_id_fk);
            booking.setBukuDetail(bukuDetail.find(String.valueOf(booking.getBukuDetails_id_fk())));
            
            return booking;
        } catch (SQLException e) {
            System.out.println("Error Bapak: " + e.getMessage());
            return null;
        }
    }
    public Member getMember() {
        return member;
    }
    
    public void setMember(Member member) {
        this.member = member;
    }
    public BukuDetails getBukuDetail() {
        return bukuDetail;
    }
    
    public void setBukuDetail(BukuDetails bukuDetail) {
        this.bukuDetail = bukuDetail;
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
