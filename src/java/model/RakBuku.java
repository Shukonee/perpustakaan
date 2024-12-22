/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author maxeef
 */
public class RakBuku {
    private int rakbuku_id;
    private String jenis_rak;
    private String lokasi_rak;
    
    public RakBuku(int rakbuku_id, String jenis_rak, String lokasi_rak){
        this.rakbuku_id = rakbuku_id;
        this.jenis_rak = jenis_rak;
        this.lokasi_rak = lokasi_rak;
    }

    public int getRakbuku_id() {
        return rakbuku_id;
    }

    public String getJenis_rak() {
        return jenis_rak;
    }

    public String getLokasi_rak() {
        return lokasi_rak;
    }
    
}
