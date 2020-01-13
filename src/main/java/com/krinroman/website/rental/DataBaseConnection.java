package com.krinroman.website.rental;

import java.sql.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class DataBaseConnection {

    static Connection connection;

    static{
        try {
            connection = DriverManager.getConnection(System.getenv("JDBC_DATABASE_URL"));
        } catch (SQLException e) {
            System.out.println("Не удалось подключиться к базе данных");
            e.printStackTrace();
        }
    }

    private static Statement getStatement(){
        if(connection == null){
            System.out.println("Не удалось подключиться к базе данных");
            return null;
        }
        try {
            return connection.createStatement();
        } catch (SQLException e) {
            System.out.println("Не удалось создать обработчик запросов");
            e.printStackTrace();
        }
        return null;
    }

    public static List<AvitoObjectApartment> getListToTableApartment() throws SQLException {

        String query = "SELECT \"id-avito\", url, title, price, description, address, floor, \"floor-in-home\", rooms, \"url-images\"\n" +
                "\tFROM public.apartment\n"+
                "\tORDER BY id DESC;";

        Statement statement = getStatement();
        if(statement == null){
            throw new SQLException("Не удалось создать обработчик запросов");
        }

        List<AvitoObjectApartment> avitoObjectApartments = new ArrayList<>();
        ResultSet resultSet = statement.executeQuery(query);
        while(resultSet.next()){
            List<String> stringList = Arrays.asList((String[]) resultSet.getArray("url-images").getArray());
            avitoObjectApartments.add(new AvitoObjectApartment(
                    resultSet.getInt("id-avito"),
                    resultSet.getString("url"),
                    resultSet.getString("title"),
                    resultSet.getInt("price"),
                    resultSet.getString("description"),
                    resultSet.getString("address"),
                    resultSet.getInt("floor"),
                    resultSet.getInt("floor-in-home"),
                    resultSet.getInt("rooms"),
                    stringList));
        }
        return avitoObjectApartments;
    }
}
