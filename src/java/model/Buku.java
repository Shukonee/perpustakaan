package model;

import db.JDBC;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class Buku extends Model<Buku>{
    private int buku_id;
    private String nama_buku;
    private String tipe_buku;
    private String jenis_buku;
    private String tgl_terbit;
    private String author;
    private int rakbuku_id_fk;
    private boolean status_booking;
    private int jumlah;
    private int jml_tersedia;
    
    public Buku() {
        this.table = "buku";
        this.primaryKey = "buku_id";
    }
    public Buku(int buku_id, String nama_buku, String tipe_buku, String jenis_buku, String tgl_terbit, String author, int rakbuku_id_fk, boolean status_booking) {
        this.table = "buku";
        this.primaryKey = "buku_id";
        this.buku_id = buku_id;
        this.nama_buku = nama_buku;
        this.tipe_buku = tipe_buku;
        this.jenis_buku = jenis_buku;
        this.tgl_terbit = tgl_terbit;
        this.author = author;
        this.rakbuku_id_fk = rakbuku_id_fk;
        this.status_booking = status_booking;
        this.jumlah = jumlah;
        this.jml_tersedia = jml_tersedia;
    }
    
    public Buku(int buku_id, String nama_buku, String tipe_buku, String jenis_buku, String tgl_terbit, String author, int rakbuku_id_fk, boolean status_booking, int jumlah, int jml_tersedia) {
        this.table = "buku";
        this.primaryKey = "buku_id";
        this.buku_id = buku_id;
        this.nama_buku = nama_buku;
        this.tipe_buku = tipe_buku;
        this.jenis_buku = jenis_buku;
        this.tgl_terbit = tgl_terbit;
        this.author = author;
        this.rakbuku_id_fk = rakbuku_id_fk;
        this.status_booking = status_booking;
        this.jumlah = jumlah;
        this.jml_tersedia = jml_tersedia;
    }
    
    @Override
    public Buku toModel(ResultSet rs) {
        try {
            return new Buku(
                rs.getInt("buku_id"),
                rs.getString("nama_buku"),
                rs.getString("tipe_buku"),
                rs.getString("jenis_buku"),
                rs.getString("tgl_terbit"),
                rs.getString("author"),
                rs.getInt("rakbuku_id_fk"),
                rs.getBoolean("status_booking"),
                rs.getInt("jumlah"),
                rs.getInt("jml_tersedia")
            );
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
            return null;
        }
    }
    
    public Buku getBukuById(int buku_id){
        return find(String.valueOf(buku_id));
    }
    
    public int getbuku_id() {
        return buku_id;
    }
    
    public String getnama_buku() {
        return nama_buku;
    }

    public String gettipe_buku() {
        return tipe_buku;
    }

    public String getjenis_buku() {
        return jenis_buku;
    }

    public String gettgl_terbit() {
        return tgl_terbit;
    }

    public String getAuthor() {
        return author;
    }
    
    public boolean getstatus_booking() {
        return status_booking;
    }
    
//    public boolean getStatus(){
//        
//    }

    public String getJenisRak() {
            JDBC db = new JDBC();
            String jenisRak="none";
            if (db.isConnected) {
                try {
                    String sql = "SELECT jenis_rak FROM rakbuku WHERE rakbuku_id = ?";
                    PreparedStatement stmt = db.getConnection().prepareStatement(sql);
                    stmt.setInt(1, this.rakbuku_id_fk);
                    ResultSet rs = stmt.executeQuery();
                    if (rs.next()) {
                        jenisRak = rs.getString("jenis_rak"); // Data sudah di-load
                    }
                    rs.close();
                    stmt.close();
                } catch (Exception e) {
                    e.getMessage();
                } finally {
                    db.disconnect(); // Pastikan koneksi ditutup
                }
            }
        return jenisRak;
    }
}
