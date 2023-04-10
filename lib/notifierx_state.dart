/// Um enum criado para identificar os possíveis estados de um Widget,
/// loading -> indica que no momento está carregando os dados
/// error - indica que aconteceu algum problema no processo
/// ready -> indica que todos os dados foram carregados corretamente e o
/// Widget está pronto para ser exibido as informações.
enum NotifierXState {
  loading,
  error,
  ready
}