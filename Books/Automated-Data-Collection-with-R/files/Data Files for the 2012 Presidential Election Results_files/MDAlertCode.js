
        $(document).ready(function () {
				 $.support.cors = true;
                $.ajax({
                type: "GET",
                url: "https://cdn-doit.maryland.gov/Alerts.svc/GetAlert",
                processData: false,
                dataType: "jsonp",
                cache: false,
                success: function (data) {
                    alerthtml = "";
                   if (data.Title != "No alert") {
                        alerthtml += "<div id='mdgov_trendsAndAlerts' class='hidden-phone hasAlert'><div id='mdgov_alerts'>";
                        alerthtml += "<a href='" + data.URL + "'><i class='mdgov_alertIcon icon-warning-sign'></i><h2>" + data.Title + "</h2><p>" + data.Description + "</p></a>";
                        alerthtml += "</div></div>";
                    }
                    $('#mdgov_trendsAlertsWrapper').append(alerthtml);

                },
                error: function (xhr, status, error) {
                   alerthtml = "";
                  $('#mdgov_trendsAlertsWrapper').append(alerthtml);
                }
            });
        });


