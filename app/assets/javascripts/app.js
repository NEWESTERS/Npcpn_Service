// функция, отправляющая асинхронный запрос к БД
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
			data.map(function(item) {
				$('#' + target).append('<option value="'+ item[1] + '">' + item[0] + '</option>');
			})
			$('#' + target).trigger('change');
		}
	});
}

// при выборе даты в список врачей добавляются элементы
$(document).on('change', '#datepicker', function() {
	src = $('#datepicker').val();
	data = {	// объект, который будет отправлен на сервер для запроса
		to_find: 'doctor',	// какие данные нужно искать
		date: src 	// по какому значению нужно искать
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
	app_update(data, data.to_find);
});

// при выборе даты рождения заглушка в строке исчезает
$(document).on('change', '#birthdate', function() {
	$('#birthdate').attr('placeholder', '');
});

