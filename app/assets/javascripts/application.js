// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require materialize
//= require jquery.dataTables
//= require turbolinks
//= require_tree .




$(document).ready(function(){

    $('.datatable').DataTable({
        scrollY:        '50vh',
        scrollCollapse: true,
        paging:         false
    });

    // $('#query_search').autocomplete({
    //     data: {
    //       "Alzheimer's Disease": null,
    //       "Arabidopsis thaliana": null,
    //       "Homo sapiens": null,
    //       "Vaccinium corymbosum": null
    //     }
    // });
    //
    // $( "#query_search" ).keypress(function( event ) {
    //     if (event.which == 13) {
    //         event.preventDefault();
    //         console.log("Enter pressed (in #query_search)");
    //         var rawText = this.value;
    //         console.log(rawText);
    //         postCypherQuery(rawText);
    //     }
    // });
    //
    // $("#query_search_button").click(function ( event ) {
    //     console.log("#query_search_button pressed");
    //     var rawText = $("#query_search").val();
    //     console.log(rawText);
    //     postCypherQuery(rawText);
    // });
    //
    // function postCypherQuery(rawText) {
    //     var statement = "match (n) with n, [x in keys(n) WHERE n[x]='" + rawText.toString() + "'] as doesMatch where size(doesMatch) > 0 return n";
    //     var cypherQueryData = { "statements": [
    //         {
    //           "statement": statement,
    //           "parameters": null,
    //           "resultDataContents": [
    //             "row",
    //             "graph"
    //           ],
    //           "includeStats": true
    //         }
    //       ]
    //     };
    //
    //     console.log("Posting cypher query, this may take a moment:");
    //
    //     $.ajax({
    //       type: "POST",
    //       url: gon.global.neo4jCommitUrl,
    //       dataType: "json",
    //       contentType: "application/json;charset=utf-8",
    //       data: JSON.stringify(cypherQueryData),
    //       success: function( result ) {
    //           console.log("Query returned:");
    //           console.log(result);
    //       }
    //     });
    //
    // }



$('#search_input').autocomplete({
    data: {
        "Alzheimer's Disease": null,
        "Arabidopsis thaliana": null,
        "Homo sapiens": null,
        "Vaccinium corymbosum": null
    }
});

$("#search_input").keypress(function( event ) {
    if (event.which == 13) {
        event.preventDefault();
        console.log("Enter pressed (in #search_input)");
        var rawText = this.value;
        console.log(rawText);
        postCypherQuery(rawText);
    }
});

$("#search_button").click(function ( event ) {
    console.log("#search_button pressed");
    var rawText = $("#search_input").val();
    console.log(rawText);
    postCypherQuery(rawText);
});


function postCypherQuery(rawText) {
    var statement = "match (n) \nwith n, [x in keys(n) WHERE n[x]='" + rawText.replace(/'/g, "\\'") + "'] as doesMatch\nwhere size(doesMatch) > 0\nreturn n";
    var cypherQueryData = {
        "statements": [
            {
                "statement": statement,
                "parameters": null,
                "resultDataContents": [
                    "row",
                    "graph"
                ],
                "includeStats": false
            }
        ]
    };

    console.log("Posting cypher query, this may take a moment:");

    $.ajax({
        type: "POST",
        url: gon.global.neo4jCommitUrl,
        dataType: "json",
        contentType: "application/json;charset=utf-8",
        data: JSON.stringify(cypherQueryData),
        success: function( json ) {
            console.log("Query returned:");
            if (json.results.length > 0) {
                var data = json.results[0].data;
                for(var i=0; i < 10; i++) {
                    var searchResult = data[i].row[0];
                    console.log(searchResult);
                    var rowHtml = "<tr><td>" + searchResult.uuid + "</td><td>" + searchResult.name + "</td><td>" + searchResult.category + "</td><td>" + searchResult.species + "</td><td>" + searchResult.source + "</td><td>" + searchResult.source_id + "</td><td>" + searchResult.description + "</td></tr>";
                    $('#search-results-thead').append(rowHtml)
                }
            }
        }
    });

}

});

