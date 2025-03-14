class Dashboard {
  /*
  get categoriesTopWidget() {
    return this.element.querySelector('#categories-widget')
  }

  get recipesTopWidget() {
    return this.element.querySelector('#recipes-widget')
  }

  get ingredientsTopWidget() {
    return this.element.querySelector('#ingredients-widget')
  }

  get tagsTopWidget() {
    return this.element.querySelector('#tags-widget')
  }

  get latestRecipeBody() {
    return this.element.querySelector('#latest-recipes')
  }

  get ingredientTagsList() {
    return this.element.querySelector('#ingredient-tags-list')
  }

  get recipeTagsList() {
    return this.element.querySelector('#recipe-tags-list')
  }

  get topCuisinesList() {
    return this.element.querySelector('#top-cuisines-list')
  }
  */

  perform() {
    return new Promise((resolve) => {
      this.loadAndDisplay()
        .then(() => {
          console.log('loadAndDisplay done');
          resolve();
        })
        .catch(error => {
          console.log('Error loadAndDisplay:', error);
          resolve();
        });
    });
  }

  async loadAndDisplay() {
    try {
      console.log('loadTopWidgets start');
      await this.loadTopWidgets();
      console.log('loadTopWidgets done');
    } catch (error) {
      console.log('Error loadTopWidgets:', error);
    }

    try {
      console.log('loadLatestRecipes start');
      await this.loadLatestRecipes();
      console.log('loadLatestRecipes done');
    } catch (error) {
      console.log('Error loadLatestRecipes:', error);
    }

    try {
      console.log('loadListItems start');
      await this.loadListItems();
      console.log('loadListItems done');
    } catch (error) {
      console.log('Error loadListItems:', error);
    }
  }

  loadData(url) {
    
    return this.fetchUsingTurbo(url);
    /*
    return fetch(url).then(response => {
      if (!response.ok) {
        throw new Error('Network response was not ok');
      }

      return response.json();
    }).catch(error => {
      console.error('There has been a problem with your fetch operation:', error);
    });
    */
  }

  loadTopWidgets() {
    return new Promise((resolve) => {
      this.loadData('/home/top_widgets')
        .then(resolve)
        .catch(error => {
          console.log('Error loadTopWidgets:', error);
          resolve();
        });
    });
  }

  loadLatestRecipes() {
    return new Promise((resolve) => {
      this.loadData('/home/latest_recipes')
        .then(resolve)
        .catch(error => {
          console.log('Error loadLatestRecipes:', error);
          resolve();
        });
    });
  }

  loadIngredientTags() {
    return new Promise((resolve) => {
      this.loadData('/home/ingredient_tags')
        .then(resolve)
        .catch(error => {
          console.log('Error loadIngredientTags:', error);
          resolve();
        });
    });
  }

  loadRecipeTags() {
    return new Promise((resolve) => {
      this.loadData('/home/recipe_tags')
        .then(resolve)
        .catch(error => {
          console.log('Error loadRecipeTags:', error);
          resolve();
        });
    });
  }

  loadTopCuisines() {
    return new Promise((resolve) => {
      this.loadData('/home/top_cuisines')
        .then(resolve)
        .catch(error => {
          console.log('Error loadTopCuisines:', error);
          resolve();
        });
    });
  }

  async loadListItems() {
    try {
      console.log('loadIngredientTags start');
      await this.loadIngredientTags();
      console.log('loadIngredientTags done');
    } catch (error) {
      console.log('Error loadIngredientTags:', error);
    }

    try {
      console.log('loadRecipeTags start');
      await this.loadRecipeTags();
      console.log('loadRecipeTags done');
    } catch (error) {
      console.log('Error loadRecipeTags:', error);
    }

    try {
      console.log('loadTopCuisines start');
      await this.loadTopCuisines();
      console.log('loadTopCuisines done');
    } catch (error) {
      console.log('Error loadTopCuisines:', error);
    }
  }

  fetchUsingTurbo(url) {
    // Turbo.visit(url, { action: 'none', shouldCacheSnapshot: false, willRender: true, updateHistory: false });
    // Turbo.visit('/home/top_widgets', { action: 'none', shouldCacheSnapshot: false, willRender: true, updateHistory: false });
    // Turbo.navigator.startVisit('/home/top_widgets', null, { action: 'none', shouldCacheSnapshot: false, willRender: true, updateHistory: false });
    
    const href = new URL(url, window.location.origin).toString();
    return Turbo.session.preloader.preloadURL({ href });
  }
}

export default Dashboard;
