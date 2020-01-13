<%@ page import="java.util.List" %>
<%@ page import="com.krinroman.website.rental.AvitoObjectApartment" %>
<%@ page import="com.krinroman.website.rental.DataBaseConnection" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Аренда жилья</title>
    <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
</head>
<body>

<%
    List<AvitoObjectApartment> avitoObjectApartmentList = null;
    try {
        avitoObjectApartmentList = DataBaseConnection.getListToTableApartment();
    } catch (SQLException e) {
        e.printStackTrace();
    }
    int countPage = avitoObjectApartmentList.size()/20;
    if(avitoObjectApartmentList.size() % 20 != 0) countPage++;
    int numPage = 1;
    if(request.getParameter("page") != null) numPage = Integer.parseInt(request.getParameter("page"));
    if((numPage-1)*20 > avitoObjectApartmentList.size()) numPage = 1;
    int begin = (numPage-1)*20;
%>
<div class="container" style="padding:5% 0 2% 0">
    <h1>Аренда коммерческой недвижимости в Кирове <small> (Страница <%=numPage%>)</small></h1>
</div>
<%
    for(int i = begin; i < begin+20 && i < avitoObjectApartmentList.size(); i++){
        AvitoObjectApartment avitoObjectApartment = avitoObjectApartmentList.get(i);
        String url = avitoObjectApartment.getUrl();
%>
<div class="container" style="margin-bottom: 20px;">
    <div class="row border rounded" style="height: 250px;">
        <div class="col-4" style="padding-left: 0; height: 100%;">
            <%if(avitoObjectApartment.getUrlImages().isEmpty()){%>
            <a href="<%=url%>"><img src="image.jpg " target="_blank" style="object-fit: cover; width: 100%; height: 100%;"></a>
            <%}%>
            <%if(avitoObjectApartment.getUrlImages().size() == 1){%>
            <a href="<%=url%>"><img src="<%=avitoObjectApartment.getUrlImages().get(0)%>" target="_blank" style="object-fit: cover; width: 100%; height: 100%;"></a>
            <%}%>
            <%
                if(avitoObjectApartment.getUrlImages().size() > 1){
                    List<String> urlImages = avitoObjectApartment.getUrlImages();
            %>
            <a href="<%=url%>" target="_blank">
                <div id="carousel-<%=i%>" class="carousel slide" data-ride="carousel" style="height: 100% !important;">
                    <ol class="carousel-indicators">
                        <li data-target="#carousel-<%=i%>" data-slide-to="0" class="active"></li>
                        <%for(int s = 1; s < urlImages.size(); s++){%>
                        <li data-target="#carousel-<%=i%>" data-slide-to="<%=s%>"></li>
                        <%}%>
                    </ol>
                    <div class="carousel-inner">
                        <div class="carousel-item active">
                            <img src="<%=urlImages.get(0)%>" class="d-block w-100" style="object-fit: cover; width: 100%; height: 100%;">
                        </div>
                        <%for(int s = 1; s < urlImages.size(); s++){%>
                        <div class="carousel-item">
                            <img src="<%=urlImages.get(s)%>" class="d-block w-100" style="object-fit: cover; width: 100%; height: 100%;">
                        </div>
                        <%}%>
                    </div>
                    <a class="carousel-control-prev" href="#carousel-<%=i%>" role="button" data-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="sr-only">Previous</span>
                    </a>
                    <a class="carousel-control-next" href="#carousel-<%=i%>" role="button" data-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="sr-only">Next</span>
                    </a>
                </div>
            </a>
            <%}%>
        </div>
        <div class="col-8" style="max-height: 200px;">
            <a href="<%=url%>" class="btn-link"><h3><%=avitoObjectApartment.getTitle()%></h3></a>
            <div class="text-dark"><%=avitoObjectApartment.getAddress()%></div>
            <h5><%=avitoObjectApartment.getPrice()%></h5>
            <div style="height: 120px; overflow: hidden; text-overflow: ellipsis;">
                <%if(avitoObjectApartment.getDescription() != null){%>
                <%=avitoObjectApartment.getDescription()%>
                <%}%>
            </div>
            <%
                List<String> properties = new ArrayList<>();
                if(avitoObjectApartment.getRooms() == 0) properties.add("Студия");
                else properties.add("Кол-во комнат: " + avitoObjectApartment.getRooms());
                if(avitoObjectApartment.getFloor() != -1)properties.add("Этаж: " + avitoObjectApartment.getFloor());
                if(avitoObjectApartment.getFloorInHome() != -1)properties.add("Этажей в доме: " + avitoObjectApartment.getFloorInHome());
            %>
            <div class="text-secondary">
                <small>
                    <%
                        int p = 0;
                        for(String property : properties){
                            if(p != 0){
                    %>
                    <%=" | "%>
                    <%}%>
                    <%=property%>
                    <%p++;}%>
                </small>
            </div>
        </div>
    </div>
</div>
<%}%>

<div class="d-flex justify-content-center">
    <nav aria-label="Page navigation example">
        <ul class="pagination">

            <%
                int i = numPage-1;
                if(numPage == countPage) i = countPage-2;
                if(i < 1 || numPage == 1) i = 1;
                int numEndPage = i+2;
            %>
            <%if(numPage == 1){%>
            <li class="page-item disabled"><a class="page-link" href="" >Previous</a></li>
            <%}%>
            <%if(numPage != 1){%>
            <li class="page-item"><a class="page-link" href="?page=<%=numPage-1%>" >Previous</a></li>
            <%}%>
            <%for(; i <= countPage && i <= numEndPage; i++){%>
            <%if(i == numPage){%>
            <li class="page-item active" aria-current="page">
                    <span class="page-link">
                        <%=i%>
                        <span class="sr-only">(current)</span>
                    </span>
            </li>
            <%}%>
            <%if(i != numPage){%>
            <li class="page-item"><a class="page-link" href="?page=<%=i%>"><%=i%></a></li>
            <%}%>
            <%}%>
            <%if(numPage == countPage){%>
            <li class="page-item disabled"><a class="page-link" href="">Next</a></li>
            <%}%>
            <%if(numPage != countPage){%>
            <li class="page-item"><a class="page-link" href="?page=<%=numPage+1%>">Next</a></li>
            <%}%>
        </ul>
    </nav>
</div>

</body>
</html>
