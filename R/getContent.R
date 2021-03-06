#' Get naver news content from links.
#'
#'
#' @param url is naver news link.
#' @return Get data.frame(url,datetime,press,title,content).
#' @export
#' @import rvest

getContent <- function(url = url) {

  if(!identical(url,character(0))){
    if (url.exists(url)) {

        tem <- read_html(url)
        title <- tem %>% html_nodes("div.article_info h3") %>% html_text()
        Encoding(title) <- "UTF-8"

        datetime <- tem %>% html_nodes("span.t11") %>% html_text()
        datetime <- as.POSIXlt(datetime)

        if (length(datetime) == 1) {
            edittime <- ""
        }
        if (length(datetime) == 2) {
            edittime <- datetime[2]
            datetime <- datetime[1]
        }

        press <- tem %>% html_nodes("div.article_header div a img") %>% html_attr("title")
        Encoding(press) <- "UTF-8"

        content <- tem %>% html_nodes("div#articleBodyContents") %>% html_text()
        Encoding(content) <- "UTF-8"
        content <- stri_trim(content)

        # tet<-GET('https://apis.naver.com/commentBox/cbox5/web_naver_list_jsonp.json?ticket=news&templateId=view_politics&_callback=window.__cbox_jindo_callback._9023&lang=ko&country=KR&objectId=news421%2C0002040415&categoryId=&pageSize=10&indexSize=10&groupId=&page=1&initialize=true&useAltSort=true&replyPageSize=30&moveTo=&sort=&userType=')

        newsInfo <- data.frame(url = url, datetime = datetime, edittime = edittime, press = press, title = title, content = content, stringsAsFactors = F)

    } else {

        newsInfo <- data.frame(url = url, datetime = "page is moved.", edittime = "page is moved.", press = "page is moved.", title = "page is moved.", content = "page is moved.",
            stringsAsFactors = F)

    }
    return(newsInfo)
  } else { print("no news links")

    newsInfo <- data.frame(url = "no news links", datetime = "no news links", edittime = "no news links", press = "no news links", title = "no news links", content = "no news links",
                           stringsAsFactors = F)
    return(newsInfo)
    }
}
