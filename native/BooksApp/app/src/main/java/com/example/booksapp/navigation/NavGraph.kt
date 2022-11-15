package com.example.booksapp.navigation

import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.navigation.NavHostController
import androidx.navigation.NavType.Companion.IntType
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.navArgument
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

        composable(
            route = "${Screen.ViewBook.route}/{id}",
            arguments = listOf(navArgument("id") { type = IntType })
        ) {
            // TODO: implement view book screen
            Text("View book screen")
        }

        composable(
            route = "${Screen.UpdateBook.route}/{id}",
            arguments = listOf(navArgument("id") { type = IntType })
        ) {
            // TODO: implement update book screen
            Text("Update book screen")
        }


        // TODO: confirm dialog for delete book
    }
}