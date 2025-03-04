categories = [{
  name: "Appetizers",
  summary: "Appetizers are small dishes served before a meal. They can be hot or cold, and are usually savory. Appetizers are also known as hors d'oeuvres, antipasti, or starters."
},
{
  name: "Main Courses",
  summary: "Main courses are the central dishes of a meal. They are usually larger than appetizers and are served after the appetizers. Main courses can be meat, fish, poultry, or vegetarian."
},
{
  name: "Desserts",
  summary: "Desserts are sweet dishes served at the end of a meal. They can be cakes, pies, cookies, ice cream, or fruit. Desserts are also known as sweets or puddings."
},
{
  name: "Soups & Stews",
  summary: "Soups and stews are liquid dishes made by boiling ingredients in water or broth. They can be thick or thin, and are usually served hot. Soups and stews can be meat, fish, poultry, or vegetarian."
},
{
  name: "Salads",
  summary: "Salads are dishes made with raw or cooked vegetables, fruits, or grains. They can be served cold or warm, and are usually dressed with oil, vinegar, or mayonnaise. Salads can be appetizers, main courses, or side dishes."
},
{
  name: "Beverages",
  summary: "Beverages are drinks served with a meal. They can be hot or cold, and are usually non-alcoholic. Beverages can be water, tea, coffee, juice, or soda."
},
{
  name: "Breakfast",
  summary: "Breakfast is the first meal of the day. It is usually eaten in the morning, and can be sweet or savory. Breakfast can be cereal, toast, eggs, bacon, or fruit."
},
{
  name: "Sides & Accompaniments",
  summary: "Sides and accompaniments are dishes served with a main course. They can be vegetables, grains, or bread. Sides and accompaniments can be hot or cold, and are usually savory."
},
{
  name: "Vegan & Vegetarian",
  summary: "Vegan and vegetarian dishes are made without meat, fish, or poultry. They can be made with vegetables, fruits, grains, or legumes. Vegan and vegetarian dishes are also known as plant-based or meatless."
},
{
  name: "Gluten-Free",
  summary: "Gluten-free dishes are made without wheat, barley, or rye. They can be made with gluten-free grains, flours, or starches. Gluten-free dishes are suitable for people with celiac disease or gluten sensitivity."
}]

categories.each do |category|
  begin
    Category.create!(category)
  rescue => e
    puts "Failed to create category: #{category[:name]}. Error: #{e.message}"
  end
end
