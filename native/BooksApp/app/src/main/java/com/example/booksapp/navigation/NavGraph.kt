package com.example.booksapp.navigation

import androidx.compose.runtime.Composable
import androidx.navigation.NavHostController
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import com.example.booksapp.view.AddBookScreen
import com.example.booksapp.view.BooksScreen

@Composable
fun NavGraph(navController: NavHostController) {
    NavHost(
        navController = navController,
        startDestination = Screen.BookList.route
    ) {
        composable(Screen.BookList.route) {
            BooksScreen(
                navigateToBookScreen = { bookId ->
                    navController.navigate("${Screen.ViewBook.route}/$bookId")
                },
                navigateToAddBookScreen = { navController.navigate(Screen.AddBook.route) }
            )
        }

        composable(Screen.AddBook.route) {
            AddBookScreen(
                navigateBack = navController::popBackStack
            )
        }

        // TODO: add other screens
    }
}