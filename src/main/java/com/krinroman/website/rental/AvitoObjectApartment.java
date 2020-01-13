package com.krinroman.website.rental;

import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class AvitoObjectApartment {
    private long id;
    private String url;
    private String title;
    private int price;
    private String description;
    private String address;
    private int floor;
    private int floorInHome;
    private int rooms;
    private List<String> urlImages;

    public AvitoObjectApartment(long id, String url, String title, int price, String description, String address, int floor, int floorInHome, int rooms, List<String> urlImages) {
        this.id = id;
        this.url = url;
        this.title = title;
        this.price = price;
        this.description = description;
        this.address = address;
        this.floor = floor;
        this.floorInHome = floorInHome;
        this.rooms = rooms;
        this.urlImages = urlImages;
    }

    public long getId() {
        return id;
    }

    public String getUrl() {
        return url;
    }

    public String getTitle() {
        return title;
    }

    public int getPrice() {
        return price;
    }

    public String getDescription() {
        return description;
    }

    public String getAddress() {
        return address;
    }

    public int getFloor() {
        return floor;
    }

    public int getFloorInHome() {
        return floorInHome;
    }

    public int getRooms() {
        return rooms;
    }

    public List<String> getUrlImages() {
        return urlImages;
    }

    @Override
    public String toString() {
        return id + ": " + url;
    }
}
