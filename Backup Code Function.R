fun_to_get_info <- function(phone) {
  
  url_link<- rvest::read_html(as.character(phone))
  
  telefone <-tibble::tibble(
    nomes = url_link %>% rvest::html_elements(xpath = '//*[@id="controles_titles"]') %>% rvest::html_nodes('li') %>% rvest::html_text() %>% readr::parse_character(),
    atributos = ifelse(
      !is.na(url_link %>% rvest::html_elements(xpath = '//*[@id="phone_columns"]') %>% rvest::html_nodes('li') %>% rvest::html_text() %>% readr::parse_character()),
      url_link %>% rvest::html_elements(xpath = '//*[@id="phone_columns"]') %>% rvest::html_nodes('li') %>% rvest::html_text() %>% readr::parse_character(),
      url_link %>% rvest::html_elements(xpath = '//*[@id="phone_columns"]') %>% rvest::html_nodes('li') %>% rvest::html_node('i') %>% rvest::html_attr('class') %>% readr::parse_character()
    )
  ) %>% 
    dplyr::mutate('Nome do Aparelho' = url_link %>% rvest::html_elements(xpath = '//*[@id="fwide_column"]/h2') %>% rvest::html_text())
  return(telefone)
}
