ingredients = [{
  name: "Flour",
  description: "A powder obtained by grinding grain, typically wheat, and used to make bread, cakes, and pastry."
}, {
  name: "Sugar",
  description: "A sweet crystalline substance obtained from various plants, especially sugar cane and sugar beet, consisting essentially of sucrose, and used as a sweetener in food and drink."
}, {
  name: "Salt",
  description: "A white crystalline substance that gives seawater its characteristic taste and is used for seasoning or preserving food."
}, {
  name: "Butter",
  description: "A pale yellow edible fatty substance made by churning cream and used as a spread or in cooking."
}, {
  name: "Eggs",
  description: "Eggs are a versatile and nutritious ingredient, providing protein, vitamins, and minerals. They play a key role in cooking and baking, offering structure, moisture, and richness to a variety of dishes."
}, {
  name: "Milk",
  description: "Milk is a nutrient-rich, white liquid food produced by the mammary glands of mammals. It is the primary source of nutrition for young mammals, including breastfed human infants before they are able to digest solid food."
}, {
  name: "Baking powder",
  description: "A mixture of a carbonate or bicarbonate and a weak acid, and is used for raising baked goods."
}, {
  name: "Vanilla extract",
  description: "Vanilla extract is a solution containing the flavor compound vanillin as the primary ingredient. Pure vanilla extract is made by macerating and percolating vanilla pods in a solution of ethyl alcohol and water."
}, {
  name: "Chocolate chips",
  description: "Chocolate chips are small chunks of sweetened chocolate, used as an ingredient in a number of desserts (notably chocolate chip cookies and muffins), in trail mix and less commonly in some breakfast foods such as pancakes."
}, {
  name: "Cinnamon",
  description: "Cinnamon is a spice obtained from the inner bark of several tree species from the genus Cinnamomum. Cinnamon is used mainly as an aromatic condiment and flavoring additive in a wide variety of cuisines, sweet and savory dishes, breakfast cereals, snackfoods, tea, and traditional foods."
}, {
  name: "Nutmeg",
  description: "Nutmeg is the seed or ground spice of several species of the genus Myristica. Nutmeg is used for flavoring many dishes, usually in ground or grated form, and is best grated fresh in a nutmeg grater."
}, {
  name: "Cloves",
  description: "Cloves are the aromatic flower buds of a tree in the family Myrtaceae, Syzygium aromaticum. They are native to the Maluku Islands in Indonesia, and are commonly used as a spice."
}, {
  name: "Ginger",
  description: "Ginger is a flowering plant whose rhizome, ginger root or ginger, is widely used as a spice and a folk medicine. It is a herbaceous perennial which grows annual pseudostems about a meter tall bearing narrow leaf blades."
}, {
  name: "Baking soda",
  description: "Baking soda is a white crystalline powder (NaHCO3) better known to chemists as sodium bicarbonate, bicarbonate of soda, sodium hydrogen carbonate, or sodium acid carbonate. It is classified as an acid salt, formed by combining an acid (carbonic) and a base (sodium hydroxide), and it reacts with other chemicals as a mild alkali."
}, {
  name: "Pumpkin puree",
  description: "Pumpkin puree is a thick, creamy, and smooth mixture made from cooked and mashed pumpkin. It is a popular ingredient in many recipes, including pies, soups, and baked goods."
}, {
  name: "Pumpkin pie spice",
  description: "Pumpkin pie spice is a blend of warm spices, including cinnamon, ginger, nutmeg, allspice, and cloves. It is commonly used to flavor pumpkin pie and other fall desserts, such as cookies, cakes, and muffins."
}, {
  name: "Pecans",
  description: "Pecans are a type of nut that comes from the pecan tree, a species of hickory native to Mexico and the southern United States. Pecans are rich in healthy fats, fiber, and antioxidants, making them a nutritious and delicious addition to a variety of dishes."
}, {
  name: "Whipped cream",
  description: "Whipped cream is a sweetened dairy product made by whipping heavy cream until it is light and fluffy. It is commonly used as a topping for desserts, such as pies, cakes, and sundaes."
}]

ingredients.each do |ingredient|
  begin
    Ingredient.create!(ingredient)
  rescue => e
    puts "Failed to create ingredient: #{ingredient[:name]}. Error: #{e.message}"
  end
end
