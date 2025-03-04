recipes = [
  {
    name: "Spaghetti Carbonara",
    summary: "Classic Italian pasta dish with creamy egg sauce, pancetta, and Parmesan.",
    cuisine_type: "italian",
    is_vegetarian: false,
    calories: 600,
    prepare_duration: "30 minutes".to_duration,
    category_id: 2
  },
  {
    name: "Vegetable Stir-Fry",
    summary: "A mix of fresh vegetables stir-fried with a light soy sauce and garlic.",
    cuisine_type: "chinese",
    is_vegetarian: true,
    calories: 250,
    prepare_duration: "20 minutes".to_duration,
    category_id: 2
  },
  {
    name: "Chocolate Chip Cookies",
    summary: "Classic chewy cookies with gooey chocolate chips.",
    cuisine_type: "american",
    is_vegetarian: true,
    calories: 400,
    prepare_duration: "45 minutes".to_duration,
    category_id: 3
  },
  {
    name: "Cauliflower Soup",
    summary: "A creamy, vegan cauliflower soup with garlic and herbs.",
    cuisine_type: "korean",
    is_vegetarian: true,
    calories: 150,
    prepare_duration: "40 minutes".to_duration,
    category_id: 4
  },
  {
    name: "Greek Salad",
    summary: "A fresh salad with cucumbers, tomatoes, olives, and feta cheese.",
    cuisine_type: "other",
    is_vegetarian: true,
    calories: 200,
    prepare_duration: "15 minutes".to_duration,
    category_id: 5
  },
  {
    name: "Smoothie Bowl",
    summary: "A healthy smoothie bowl topped with fresh fruits and granola.",
    cuisine_type: "french",
    is_vegetarian: true,
    calories: 350,
    prepare_duration: "10 minutes".to_duration,
    category_id: 6
  },
  {
    name: "Scrambled Eggs",
    summary: "Fluffy and creamy scrambled eggs with a touch of cheese.",
    cuisine_type: "american",
    is_vegetarian: true,
    calories: 300,
    prepare_duration: "10 minutes".to_duration,
    category_id: 7
  },
  {
    name: "Garlic Bread",
    summary: "Crispy toasted bread with garlic butter and parsley.",
    cuisine_type: "italian",
    is_vegetarian: true,
    calories: 350,
    prepare_duration: "15 minutes".to_duration,
    category_id: 8
  },
  {
    name: "Vegan Burritos",
    summary: "Tortilla wraps filled with seasoned rice, beans, avocado, and veggies.",
    cuisine_type: "mexican",
    is_vegetarian: true,
    calories: 450,
    prepare_duration: "30 minutes".to_duration,
    category_id: 9
  },
  {
    name: "Grilled Salmon",
    summary: "Perfectly grilled salmon fillets with lemon and dill.",
    cuisine_type: "american",
    is_vegetarian: false,
    calories: 350,
    prepare_duration: "25 minutes".to_duration,
    category_id: 2
  },
  {
    name: "Margarita Pizza",
    summary: "A simple pizza with fresh mozzarella, tomatoes, and basil.",
    cuisine_type: "italian",
    is_vegetarian: true,
    calories: 700,
    prepare_duration: "25 minutes".to_duration,
    category_id: 2
  },
  {
    name: "Tofu Stir-Fry",
    summary: "Stir-fried tofu with broccoli, peppers, and a soy-based sauce.",
    cuisine_type: "chinese",
    is_vegetarian: true,
    calories: 300,
    prepare_duration: "25 minutes".to_duration,
    category_id: 2
  },
  {
    name: "Apple Pie",
    summary: "A traditional dessert with spiced apples encased in flaky pastry.",
    cuisine_type: "american",
    is_vegetarian: true,
    calories: 500,
    prepare_duration: "1 hour 15 minutes".to_duration,
    category_id: 3
  },
  {
    name: "Tomato Basil Soup",
    summary: "A creamy tomato soup with fresh basil and garlic.",
    cuisine_type: "italian",
    is_vegetarian: true,
    calories: 250,
    prepare_duration: "40 minutes".to_duration,
    category_id: 4
  },
  {
    name: "Caprese Salad",
    summary: "A simple salad with mozzarella, tomatoes, basil, and balsamic vinegar.",
    cuisine_type: "italian",
    is_vegetarian: true,
    calories: 180,
    prepare_duration: "10 minutes".to_duration,
    category_id: 5
  },
  {
    name: "Iced Coffee",
    summary: "A refreshing iced coffee made with chilled espresso and milk.",
    cuisine_type: "american",
    is_vegetarian: true,
    calories: 100,
    prepare_duration: "5 minutes".to_duration,
    category_id: 6
  },
  {
    name: "Pancakes",
    summary: "Fluffy pancakes served with syrup and fresh berries.",
    cuisine_type: "american",
    is_vegetarian: true,
    calories: 350,
    prepare_duration: "20 minutes".to_duration,
    category_id: 7
  },
  {
    name: "French Fries",
    summary: "Crispy golden fries served with ketchup or your favorite dip.",
    cuisine_type: "american",
    is_vegetarian: true,
    calories: 400,
    prepare_duration: "30 minutes".to_duration,
    category_id: 8
  },
  {
    name: "Chickpea Curry",
    summary: "A hearty curry made with chickpeas, tomatoes, and spices.",
    cuisine_type: "indian",
    is_vegetarian: true,
    calories: 350,
    prepare_duration: "45 minutes".to_duration,
    category_id: 9
  },
  {
    name: "Beef Tacos",
    summary: "Tacos filled with seasoned ground beef, lettuce, cheese, and salsa.",
    cuisine_type: "mexican",
    is_vegetarian: false,
    calories: 500,
    prepare_duration: "25 minutes".to_duration,
    category_id: 2
  }
]

recipes.each do |recipe|
  begin
    Recipe.create!(recipe)
  rescue => e
    puts "Failed to create recipe: #{recipe[:name]}. Error: #{e.message}"
  end
end
