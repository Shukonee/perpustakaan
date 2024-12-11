package model;

public class Buku {
    private int bukuId;
    private String namaBuku;
    private String tipeBuku;
    private String jenisBuku;
    private String tglTerbit;
    private String author;
    private String jenisRak;

    public Buku(int bukuId, String namaBuku, String tipeBuku, String jenisBuku, String tglTerbit, String author, String jenisRak) {
        this.bukuId = bukuId;
        this.namaBuku = namaBuku;
        this.tipeBuku = tipeBuku;
        this.jenisBuku = jenisBuku;
        this.tglTerbit = tglTerbit;
        this.author = author;
        this.jenisRak = jenisRak;
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
        return jenisRak;
    }
}
