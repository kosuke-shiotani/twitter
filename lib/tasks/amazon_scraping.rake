namespace :amazon_scraping do

    # bundle exec rails 'rakuten_crawling:start'とターミナルで打つことでrakeタスクを実行
    desc 'Amazonサイトのスクレイピング'
    task :start do
        begin
            url_format = Regexp.new('https://www.amazon.co.jp/gp/new-releases/.*/ref=zg_bsnr_nav_0')
            url = 'https://www.amazon.co.jp/gp/new-releases/ref=zg_bs_tab'
            target_urls = []

            Anemone.crawl(url, :depth_limit => 1) do |anemone|
                anemone.on_every_page do |page|
                    puts page.url
                    target_urls.push(page.url.to_s) if(url_format.match(page.url.to_s))
                end
            end

            # スクレイピング対象とするurlをランダムで取得
            target_url = target_urls[rand(target_urls.size)]
            doc = Nokogiri.HTML(open(target_url))

            3.times do |num|
                path = doc.css('.zg-item-immersion')[num].children.children.children[1].children[0].attributes['href'].value
                product_url = 'https://www.amazon.co.jp' + URI.unescape(path)
                ranking = num + 1
                name = doc.css('.p13n-sc-truncate-mobile-type')[num].children.text.strip
                image = doc.css('.a-spacing-small')[num].children[0].attributes['src'].value
                price = doc.css('.p13n-sc-price')[num].children.text

                puts product_url
                puts ranking
                puts name
                puts image
                puts price
            end
            puts 'スクレイピングが完了しました'
        rescue => e
            puts e.message
            puts e.backtrace
        end
    end
end