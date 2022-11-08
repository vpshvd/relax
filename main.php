<?php
    $mysqli = new mysqli('localhost','root','root','relax', '3306');
    $sql = file_get_contents('query.sql');
    $response = $mysqli->query($sql)->fetch_all(MYSQLI_ASSOC);

    echo "<table>";
    echo "<tr>";
    echo "<th>date</th>";
    echo "<th>total</th>";
    echo "<th>count</th>";
    echo "<th>total_completed</th>";
    echo "<th>count_completed</th>";
    echo "<th>total_liqpay</th>";
    echo "<th>count_liqpay</th>";
    echo "</tr>";

    foreach ($response as $row) {
        echo '<tr>';
        foreach ($row as $cell) {
            echo '<td>'.htmlspecialchars($cell).'</td>';
        }
        echo '</tr>';
    }
    echo '</table>';