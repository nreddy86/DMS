document.addEventListener('DOMContentLoaded', function () {
    let svgTemplate = document.getElementById('svgWheel');
    let tRow = document.getElementById('t-row');

    const domWheels = Array.from(
        document.getElementsByClassName('c-teeth_wheel')
    );
    domWheels.forEach(domWheel => {
        let clonedSvg = svgTemplate.content.cloneNode(true);
        domWheel.appendChild(clonedSvg);
    });

    const svgWheels = Array.from(document.getElementsByTagName('svg'));

    svgWheels.forEach(wheel => {
        wheel.addEventListener('click', handleClick);
    });

    window.allTeeth = {};

    function handleClick(e) {
        // e.target.style.fill = 'red';
        const group = e.target.closest('g');
        const teethWheel = e.target.closest('.c-teeth');
        if (group) {
            group.classList.toggle('active');
        }
        let teethNo = teethWheel.dataset.teethNo;

        let paths = Array.from(teethWheel.querySelectorAll('.active'));
        let overview = [];
        if (paths.length) {
            overview = paths.map(path => {
                let [filteredClass] = Array.from(path.classList).filter(className => {
                    return /\d+/.test(className);
                });
                return filteredClass.match(/\d+/)[0];
            });
        }
        allTeeth[teethNo] = overview;
    }

    $('.list-group-flush').on('click', 'a', function (event) {
        event.preventDefault();
        if (Object.keys(allTeeth).length) {
            $('.c-table tbody').html('');
            Object.keys(allTeeth).forEach(key => {
                if (allTeeth[key].length) {
                    let row = tRow.content.cloneNode(true);
                    let $row = $('<div></div').append(row);
                    $row.find('.t-data').html(new Date().toLocaleDateString());
                    $row.find('.t-no').html(key);
                    $row.find('.t-surface').html(allTeeth[key].toString());
                    $row.find('.t-des').html(event.target.textContent);
                    $row.find('.t-amont').html($(this).attr("data-amount"));
                    $row.find('.t-delete').attr('data-teeth-no', key);
                    $('.c-table tbody').append($row.html());
                }
            });
        }
    });
    $('.c-table tbody').on('click', '.t-delete', function (event) {
        event.preventDefault();
        let teethNo = event.currentTarget.dataset.teethNo;
        let $trToDelete = $(this).closest('tr');
        $trToDelete.remove();
        $(`.c-teeth[data-teeth-no='${teethNo}'] svg .part`).removeClass('active');
        if (teethNo in allTeeth) {
            delete allTeeth[teethNo];
        }
    });

    $("#btnSave").click(function () {
        var result = getData();
        if (result.length) {
            $.ajax(
                {
                    type: "POST", //HTTP POST Method
                    url: "/Home/SaveChart", // Controller/View 
                    dataType: "json",
                    data: { patientId: $("#patientId").val(), payload: JSON.stringify(result) }
                });
        }

    });

    function getData() {
        var table = $('.c-table')[0];
        var rows = table.tBodies[0].rows,
            header_row = rows[0],
            result = [],
            header = [],
            i, j, cell, row, row_data;
        // extract header
        header_row = $('.c-table')[0].rows[0];
        for (i = 0, l = header_row.cells.length; i < l; i++) {
            cell = header_row.cells[i];
            header.push(cell.textContent || cell.innerText);
        }

        // extract values
        for (i = 0, l = rows.length; i < l; i++) {
            row = rows[i];
            console.log(row);
            row_data = { "CreatedOn": row.cells[0].innerText, "Tooth": row.cells[1].innerText, "Surface": row.cells[2].innerText, "Description": row.cells[3].innerText, "Amount": row.cells[4].innerText, "Status": row.cells[5].innerText, "Dentist": "Test", "PatientId": 1 };
            result.push(row_data);
        }
        return result;
    }
});
