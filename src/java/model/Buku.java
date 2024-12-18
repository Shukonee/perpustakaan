package model;

import db.JDBC;
import java.sql.ResultSet;
import java.sql.PreparedStatement;

public class Buku {
    private int bukuId;
    private String namaBuku;
    private String tipeBuku;
    private String jenisBuku;
    private String tglTerbit;
    private String author;
    private int rakbuku;

    public Buku(int bukuId, String namaBuku, String tipeBuku, String jenisBuku, String tglTerbit, String author, int rakbuku) {
        this.bukuId = bukuId;
        this.namaBuku = namaBuku;
        this.tipeBuku = tipeBuku;
        this.jenisBuku = jenisBuku;
        this.tglTerbit = tglTerbit;
        this.author = author;
        this.rakbuku = rakbuku;
    }

    // Getter dan Setter untuk semua atribut
    public int getBukuId() {
        return bukuId;
    }

    public String getNamaBuku() {
        return namaBuku;
    }

    public String getTipeBuku() {
        return tipeBuku;
    }

    public String getJenisBuku() {
        return jenisBuku;
    }

    public String getTglTerbit() {
        return tglTerbit;
    }

    public String getAuthor() {
        return author;
    }

    public String getJenisRak() {
            JDBC db = new JDBC();
            String jenisRak="none";
            if (db.isConnected) {
                try {
                    String sql = "SELECT jenis_rak FROM rakbuku WHERE rakbuku_id = ?";
                    PreparedStatement stmt = db.getConnection().prepareStatement(sql);
                    stmt.setInt(1, this.rakbuku);
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
