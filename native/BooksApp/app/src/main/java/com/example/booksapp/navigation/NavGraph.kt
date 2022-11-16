package com.example.booksapp.navigation

import androidx.compose.runtime.Composable
import androidx.navigation.NavHostController
import androidx.navigation.NavType.Companion.IntType
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.navArgument
import com.example.booksapp.view.AddBookScreen
import com.example.booksapp.view.BooksScreen
import com.example.booksapp.view.UpdateBookScreen
import com.example.booksapp.view.ViewBookScreen

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
            backStackEntry -> val id = backStackEntry.arguments?.getInt("id") ?: 0
            ViewBookScreen(
                id = id,
                navigateToUpdateBookScreen = { navController.navigate("${Screen.UpdateBook.route}/$id") },
                navigateBack = navController::popBackStack
            )
        }

        composable(
            route = "${Screen.UpdateBook.route}/{id}",
            arguments = listOf(navArgument("id") { type = IntType })
        ) {
            backStackEntry -> val id = backStackEntry.arguments?.getInt("id") ?: 0
            UpdateBookScreen(id = id, navigateBack = navController::popBackStack)
        }


        // TODO: confirm dialog for delete book
    }
}