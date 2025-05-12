                        package com.bancosangue.controller;
                        import java.util.List;
                        import java.util.Map;

                        import org.springframework.beans.factory.annotation.Autowired;
                        import org.springframework.web.bind.annotation.GetMapping;
                        import org.springframework.web.bind.annotation.PostMapping;
                        import org.springframework.web.bind.annotation.RequestBody;
                        import org.springframework.web.bind.annotation.RequestMapping;
                        import org.springframework.web.bind.annotation.RestController;

                        import com.bancosangue.model.Candidato;
                        import com.bancosangue.repository.CandidatoRepository;
                        import com.bancosangue.service.CandidatoService;

                        @RestController
                        @RequestMapping("/api")
                        public class CandidatoController {

                            @Autowired
                            private CandidatoRepository repository;

                            @PostMapping("/upload")
                            public void salvarTodos(@RequestBody List<Candidato> candidatos) {
                                repository.saveAll(candidatos);
                            }

                            @GetMapping("/todos")
                            public List<Candidato> listarTodos() {
                                return repository.findAll();
                            }

                            @Autowired
                        private CandidatoService service;

                        @GetMapping("/por-estado")
                        public Map<String, Long> porEstado() {
                            return service.porEstado();
                        }

                        @GetMapping("/imc-faixa")
                        public Map<String, Double> imcPorFaixa() {
                            return service.imcPorFaixaEtaria();
                        }

                        @GetMapping("/obesos")
                        public Map<String, Double> obesosPorSexo() {
                            return service.percentualObesosPorSexo();
                        }

                        @GetMapping("/idade-sangue")
                        public Map<String, Double> idadePorSangue() {
                            return service.mediaIdadePorTipoSanguineo();
                        }

                        @GetMapping("/doadores")
                        public Map<String, Long> doadoresCompatíveis() {
                            return service.doadoresPorReceptor();
                        }

                        }
