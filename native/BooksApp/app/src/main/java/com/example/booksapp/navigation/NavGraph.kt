package com.example.booksapp.navigation

import androidx.compose.runtime.Composable
import androidx.navigation.NavHostController
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import com.example.booksapp.view.books_list.BooksListScreen

@Composable
fun NavGraph(navController: NavHostController) {
    NavHost(
        navController = navController,
        startDestination = Screen.BookList.route
    ) {
        composable(Screen.BookList.route) {
            BooksListScreen(
                navigateToAddBookScreen = {
                    navController.navigate(Screen.AddBook.route)
                }
            )
        }
        composable(Screen.AddBook.route) {

        }
    }
}