package com.bancosangue.service;

import com.bancosangue.model.Candidato;
import com.bancosangue.repository.CandidatoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.Period;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class CandidatoService {

    @Autowired
    private CandidatoRepository repository;

    private int calcularIdade(LocalDate dataNascimento) {
        if (dataNascimento == null) return 0; // ou lançar uma exceção controlada
        return Period.between(dataNascimento, LocalDate.now()).getYears();
    }


    private double calcularIMC(Candidato c) {
        return c.getPeso() / (c.getAltura() * c.getAltura());
    }

    private boolean podeDoar(Candidato c) {
        int idade = calcularIdade(c.getDataNasc());
        return idade >= 16 && idade <= 69 && c.getPeso() > 50;
    }

    public Map<String, Long> porEstado() {
        return repository.findAll().stream()
                .collect(Collectors.groupingBy(Candidato::getEstado, Collectors.counting()));
    }

    public Map<String, Double> imcPorFaixaEtaria() {
        return repository.findAll().stream()
                .filter(c -> c.getDataNasc() != null)
                .collect(Collectors.groupingBy(
                        c -> {
                            int idade = calcularIdade(c.getDataNasc());
                            int faixa = (idade / 10) * 10;
                            return faixa + " a " + (faixa + 9);
                        },
                        Collectors.averagingDouble(this::calcularIMC)
                ));
    }


    public Map<String, Double> percentualObesosPorSexo() {
        return repository.findAll().stream()
                .collect(Collectors.groupingBy(
                        Candidato::getSexo,
                        Collectors.collectingAndThen(
                                Collectors.toList(),
                                list -> 100.0 * list.stream().filter(c -> calcularIMC(c) > 30).count() / list.size()
                        )
                ));
    }

    public Map<String, Double> mediaIdadePorTipoSanguineo() {
        return repository.findAll().stream()
                .collect(Collectors.groupingBy(
                        Candidato::getTipoSanguineo,
                        Collectors.averagingInt(c -> calcularIdade(c.getDataNasc()))
                ));
    }

    public Map<String, Long> doadoresPorReceptor() {
        Map<String, List<String>> compatibilidade = Map.of(
                "A+", List.of("A+", "A-", "O+", "O-"),
                "A-", List.of("A-", "O-"),
                "B+", List.of("B+", "B-", "O+", "O-"),
                "B-", List.of("B-", "O-"),
                "AB+", List.of("A+", "B+", "O+", "AB+", "A-", "B-", "O-", "AB-"),
                "AB-", List.of("A-", "B-", "O-", "AB-"),
                "O+", List.of("O+", "O-"),
                "O-", List.of("O-")
        );

        List<Candidato> validos = repository.findAll().stream()
                .filter(this::podeDoar)
                .collect(Collectors.toList());

        Map<String, Long> resultado = new HashMap<>();
        for (String receptor : compatibilidade.keySet()) {
            long count = validos.stream()
                    .filter(c -> compatibilidade.get(receptor).contains(c.getTipoSanguineo()))
                    .count();
            resultado.put(receptor, count);
        }
        return resultado;
    }
}
