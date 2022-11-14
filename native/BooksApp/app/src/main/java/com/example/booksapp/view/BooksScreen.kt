package com.example.booksapp.view.books_list

import androidx.compose.material.TopAppBar
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Add
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.hilt.navigation.compose.hiltViewModel
import com.example.booksapp.view.BooksViewModel

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun BooksListScreen(
    viewModel: BooksViewModel = hiltViewModel(),
    navigateToAddBookScreen: () -> Unit,
) {
    val books = viewModel.books;
    Scaffold (
        topBar = {
            TopAppBar(
                title = {
                    Text(text = "Books")
                }
            )
        },
        content = {

        },
        floatingActionButton = {
            FloatingActionButton(onClick = navigateToAddBookScreen) {
                Icon(
                    imageVector = Icons.Default.Add,
                    contentDescription = "Add book"
                )
            }
        }
    )
}