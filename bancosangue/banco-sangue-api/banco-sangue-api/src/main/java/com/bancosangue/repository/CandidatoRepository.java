package com.bancosangue.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.bancosangue.model.Candidato;

public interface CandidatoRepository extends JpaRepository<Candidato, Long> {
}
