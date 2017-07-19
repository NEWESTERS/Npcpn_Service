// функция, отправляющая асинхронный запрос к БД
function g_update(source, target) {
	$.ajax({
		// адрес запроса
		url: '/app/db',
		type: 'GET',
		data: source,
		success: function(data) {
			if (data[0] == '+') {
				$('#warning').show(200);
			} else {
				$('#warning').hide(200);
			}
		}
	});
}

$(document).on('change', '#doctor', function() {
	src = $('#date').val();
	data = {
		to_find: 'is_schedule',
		date: src,
		doctor_id: $('#doctor' + ' option:selected').val()
	};
	g_update(data, data.to_find);
});

// при выборе даты рождения заглушка в строке исчезает
$(document).on('change', '#date', function() {
	$('#date').attr('placeholder', '');
	src = $('#date').val();
	data = {
		to_find: 'is_schedule',
		date: src,
		doctor_id: $('#doctor' + ' option:selected').val()
	};
	g_update(data, data.to_find);
});

$(document).on('change', '#break', function() {
	if ($('#break').val() == '0') {
		$('#break-start-hour').prop( "disabled", true );
		$('#break-start-minute').prop( "disabled", true );
		$('#break-end-hour').prop( "disabled", true );
		$('#break-end-minute').prop( "disabled", true );
	} else {
		$('#break-start-hour').prop( "disabled", false );
		$('#break-start-minute').prop( "disabled", false );
		$('#break-end-hour').prop( "disabled", false );
		$('#break-end-minute').prop( "disabled", false );
	};
});





