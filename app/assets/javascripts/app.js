// функция, отправляющая асинхронный запрос к БД
function handle_error(data) {
	switch(data) {
		case '0':
			$('#info>label').text('В выбранный день нет cвободных врачей');
			$('#seance').empty();
			$('#info>label').show(300);
			return true
		case '1':
			$('#info>label').text('Нет доступных вариантов');
			$('#info>label').show(300);
			return true
		case '2':
			$('#info>label').text('У выбранного врача в выбранный день нет свободных сеансов');
			$('#info>label').show(300);
			return true
		default:
			$('#info>label').hide(300);
			return false
	};
};
function app_update(source, target) {
	$.ajax({
		// адрес запроса
		url: '/app/db',
		type: 'GET',
		data: source,
		success: function(data) {
			// в случае успеха клиенту возвращается JSON в виде
			// [["Ivanov Ivan Ivanovich",1],["Alekseev Aleksey Alexeevich",3]]
			$('#' + target).empty();
			// каждый элемент массива добавляется как option в select
			if( !handle_error(data[0][0]) ) {
				data.map(function(item) {
					$('#' + target).append('<option value="'+ item[1] + '">' + item[0] + '</option>');
				})
				$('#' + target).trigger('change');
			}
		}
	});
}

// при выборе даты в список врачей добавляются элементы
$(document).on('change', '#datepicker', function() {
	src = [$('#affilate').val(), $('#datepicker').val()];
	data = {	// объект, который будет отправлен на сервер для запроса
		to_find: 'doctor',	// какие данные нужно искать
		date: src[1], 	// по какому значению нужно искать
		affilate: src[0]
	};
	app_update(data, data.to_find);
	$('#datepicker').attr('placeholder', '');
});

$(document).on('change', '#affilate', function() {
	src = [$('#affilate').val(), $('#datepicker').val()];
	data = {	// объект, который будет отправлен на сервер для запроса
		to_find: 'doctor',	// какие данные нужно искать
		date: src[1], 	// по какому значению нужно искать
		affilate: src[0]
	};
	app_update(data, data.to_find);
	$('#datepicker').attr('placeholder', '');
});

// при выборе врача в список сеансов добавляются элементы
$(document).on('change', '#doctor', function() {
	src = $('#datepicker').val();
	data = {
		to_find: 'seance',
		date: src,
		doctor_id: $('#doctor' + ' option:selected').val()
	};
	$("#seance").empty();
	app_update(data, data.to_find);
});

// при выборе даты рождения заглушка в строке исчезает
$(document).on('change', '#birthdate', function() {
	$('#birthdate').attr('placeholder', '');
});

