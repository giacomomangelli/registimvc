package it.prova.raccoltafilmspringmvc.repository.film;

import java.util.List;

import it.prova.raccoltafilmspringmvc.model.Film;

public interface CustomFilmRepository {
	
	public List<Film> findByExample(Film filmInstance);

}
