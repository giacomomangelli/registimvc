package it.prova.raccoltafilmspringmvc.repository.film;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;

import org.apache.commons.lang3.StringUtils;

import it.prova.raccoltafilmspringmvc.model.Film;

public class CustomFilmRepositoryImpl implements CustomFilmRepository {
	
	@PersistenceContext
	private EntityManager entityManager;

	@Override
	public List<Film> findByExample(Film filmInstance) {
		
		List<String> whereClauses = new ArrayList<>();
		Map<String, Object> parameterMap = new HashMap<>();
		
		StringBuilder queryBuilder = new StringBuilder("select f from Film f left join fetch f.regista r where f.id = f.id");
		
		if(StringUtils.isNotBlank(filmInstance.getTitolo())) {
			whereClauses.add(" f.titolo = :titolo ");
			parameterMap.put("titolo" , filmInstance.getTitolo());
		}
		if(StringUtils.isNotBlank(filmInstance.getGenere())) {
			whereClauses.add(" f.genere = :genere ");
			parameterMap.put("genere" , filmInstance.getGenere());
		}		
		if(filmInstance.getMinutiDurata()!=null && filmInstance.getMinutiDurata()>0) {
			whereClauses.add(" f.minutiDurata >= :minutiDurata ");
			parameterMap.put("minutiDurata" , filmInstance.getMinutiDurata());
		}
		if(filmInstance.getDataPubblicazione()!=null) {
			whereClauses.add(" f.dataPubblicazione >= :dataPubblicazione ");
			parameterMap.put("dataPubblicazione" , filmInstance.getDataPubblicazione());
		}
		if(filmInstance.getRegista()!=null && filmInstance.getRegista().getId()!=null && filmInstance.getRegista().getId()>0) {
			whereClauses.add(" r = :regista ");
			parameterMap.put("regista" , filmInstance.getRegista());
		}
				
		queryBuilder.append(!whereClauses.isEmpty()?" and ":"");
		queryBuilder.append(StringUtils.join(whereClauses, " and "));
		TypedQuery<Film> typedQuery = entityManager.createQuery(queryBuilder.toString(), Film.class);

		for (String key : parameterMap.keySet()) {
			typedQuery.setParameter(key, parameterMap.get(key));
		}
		
		return typedQuery.getResultList();
		
	}

	
	
}
