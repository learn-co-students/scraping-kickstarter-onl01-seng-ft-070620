require 'nokogiri'
require 'pry'

  def create_project_hash
    html = File.read('fixtures/kickstarter.html')
 
    kickstarter = Nokogiri::HTML(html)
    
    projects = {}

    #iterate through the projects
    kickstarter.css("li.project.grid_4").each do |project|
      title = project.css("h2.bbcard_name strong a").text
      projects[title.to_sym] = {
        :image_link =>  project.css("div.project-thumbnail a img").attribute("src").value, 
        :description => project.css("p.bbcard_blurb").text, 
        :location => project.css("span.location-name").text,
        :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%", " ").to_i
      }      
    end

    #return the projects
    projects

  end

  create_project_hash

  # projects: kickstarter.css("li.project.grid_4")
  # title: project.css("h2.bbcard_name strong a").text
  #image link:  project.css("div.project-thumbnail a img").attribute("src").value
  #description: (with added strip): project.css("p.bbcard_blurb").text.strip
  #location: project.css("span.location-name").text
  #% funded: project.css("ul.project-stats li.first.funded strong").text.gsub("%", " ").to_i
  ## note for % funded: the space between project-stats and li signifies going the next level down (arrows). on the website it says "first funded" with a space, but we can't have spaces...because they signify parents/levels, so we add a "." in there to take away the space. 
    


