<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1"> <!-- So that mobile will display zoomed in -->
    <meta http-equiv="X-UA-Compatible" content="IE=edge"> <!-- enable media queries for windows phone 8 -->
    <meta name="format-detection" content="telephone=no"> <!-- disable auto telephone linking in iOS -->
    <title>Database Maintenace</title>

    <style type="text/css">
        body {
            margin: 0;
            padding: 0;
            -ms-text-size-adjust: 100%;
            -webkit-text-size-adjust: 100%;
        }

        table {
            border-spacing: 0;
        }

            table td {
                border-collapse: collapse;
            }

        .ExternalClass {
            width: 100%;
        }

            .ExternalClass,
            .ExternalClass p,
            .ExternalClass span,
            .ExternalClass font,
            .ExternalClass td,
            .ExternalClass div {
                line-height: 100%;
            }

        .ReadMsgBody {
            width: 100%;
            background-color: #ebebeb;
        }

        table {
            mso-table-lspace: 0pt;
            mso-table-rspace: 0pt;
        }

        img {
            -ms-interpolation-mode: bicubic;
        }

        .yshortcuts a {
            border-bottom: none !important;
        }

        @@media screen and (max-width: 599px) {
            table[class="force-row"],
            table[class="container"] {
                width: 100% !important;
                max-width: 100% !important;
            }
        }

        @@media screen and (max-width: 400px) {
            td[class*="container-padding"] {
                padding-left: 12px !important;
                padding-right: 12px !important;
            }
        }

        .ios-footer a {
            color: #aaaaaa !important;
            text-decoration: underline;
        }

        .button {
            background-color: #e9e9e9;
            color: black;
            border-radius: 10px;
            padding: 20px;
        }

        .centered {
            text-align: center;
        }

        table.table-bordered {
            color: #333; /* Lighten up font color */
            font-family: Helvetica, Arial, sans-serif; /* Nicer font */
            width: 640px;
            border-collapse: collapse;
            border-spacing: 0;
        }

        td.table-bordered, th.table-bordered {
            border: 1px solid #CCC;
            height: 30px;
        }
        /* Make cells a bit taller */

        th.table-bordered {
            background: #F3F3F3; /* Light grey background */
            font-weight: bold; /* Make sure they're bold */
        }

        td.table-bordered {
            background: #FAFAFA; /* Lighter grey background */
            text-align: center; /* Center our text */
        }
    </style>

</head>
<body style="margin:0; padding:0;" bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

    <!-- 100% background wrapper (grey background) -->
    <table border="0" width="100%" height="100%" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
            <td align="center" valign="top" bgcolor="#FFFFFF" style="background-color: #FFFFFF;">

                <br>

                <!-- 600px container (white background) -->
                <table border="0" width="600" cellpadding="0" cellspacing="0" class="container" style="width:600px;max-width:600px">
                    <tr>
                        <td class="container-padding header" align="left" style="font-family:Helvetica, Arial, sans-serif;font-size:24px;font-weight:bold;padding-bottom:12px;color:#0016BB;padding-left:24px;padding-right:24px">
							Daily Database Maintenance Report
                        </td>
                    </tr>
                    <tr>
                        <td class="container-padding content" align="left" style="padding-left:24px;padding-right:24px;padding-top:12px;padding-bottom:12px;background-color:#ffffff">
                            <br>

                            <div class="title" style="font-family:Helvetica, Arial, sans-serif;font-size:18px;font-weight:600;color:#374550">Daily Database Maintenance Report</div>
                            <br>

                            <div class="body-text" style="font-family:Helvetica, Arial, sans-serif;font-size:14px;line-height:20px;text-align:left;color:#333333">
                                <p>
                                    Below is a summary of sales entered into the Sales Process Accelerator between @Model.StartDate and @Model.EndDate (at time of email):
                                </p>
                                <br><br>
                                <h4>By Agent:</h4>
                                <table class="table-bordered">
                                    <thead>
                                        <tr>
                                            <th class="table-bordered">Agent ID</th>
                                            <th class="table-bordered">Total Sales</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        @foreach (var agent in Model.AgentSales)
                                        {
                                            <tr>
                                                <td class="table-bordered">@agent.Key</td>
                                                <td class="table-bordered">@agent.Value</td>
                                            </tr>
                                        }
                                    </tbody>
                                </table>
                                <br />
@if (Model.StateSales != null) {
                                <h4>By State:</h4>
                                <table class="table-bordered">
                                    <thead>
                                        <tr>
                                            <th class="table-bordered">State</th>
                                            <th class="table-bordered">Total Sales</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        @foreach (var state in Model.StateSales)
                                        {
                                            <tr>
                                                <td class="table-bordered">@state.Key</td>
                                                <td class="table-bordered">@state.Value</td>
                                            </tr>
                                        }
                                    </tbody>
                                </table>
                                <br />
}
                                @if (Model.TeamSales != null) { 
                                <h4>By SalesTeam:</h4>
                                <table class="table-bordered">
                                    <thead>
                                        <tr>
                                            <th class="table-bordered">Team</th>
                                            <th class="table-bordered">Total Sales</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        @foreach (var team in Model.TeamSales)
                                        {
                                            <tr>
                                                <td class="table-bordered">@team.Key</td>
                                                <td class="table-bordered">@team.Value</td>
                                            </tr>
                                        }
                                    </tbody>
                                </table>
                                }
                                <br><br>
                            </div>

                        </td>
                    </tr>
                    <tr>
                        <td class="container-padding footer-text" align="left" style="font-family:Helvetica, Arial, sans-serif;font-size:12px;line-height:16px;color:#aaaaaa;padding-left:24px;padding-right:24px">

                            <br>
                            <strong>@Model.LegalName</strong><br>
                            <span class="ios-footer">
                                @Model.StreetAddress<br>
                                @Model.City, @Model.State @Model.Zipcode<br>
                            </span>
                            <a href="http://@Model.Website" style="color:#aaaaaa">@Model.Website</a><br>

                            <br><br>

                        </td>
                    </tr>
                </table>
                <!--/600px container -->


            </td>
        </tr>
    </table>
    <!--/100% background wrapper-->

</body>
</html>