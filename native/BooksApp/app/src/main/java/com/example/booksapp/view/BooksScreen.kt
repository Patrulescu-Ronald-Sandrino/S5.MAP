package com.example.booksapp.view

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.Card
import androidx.compose.material.ExperimentalMaterialApi
import androidx.compose.material.TopAppBar
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Add
import androidx.compose.material.icons.filled.Delete
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.runtime.snapshots.SnapshotStateList
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.hilt.navigation.compose.hiltViewModel
import com.example.booksapp.domain.Book

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun BooksScreen(
    viewModel: BooksViewModel = hiltViewModel(),
    navigateToBookScreen: (id: Int) -> Unit,
    navigateToAddBookScreen: () -> Unit,
) {
//    val books by viewModel.books.observeAsState()
//    val books by remember { mutableStateOf(viewModel.books) }

    val uiState = viewModel.uiState


    Scaffold(
        topBar = { TopAppBar(title = { Text(text = "Books") }) },
        content = {
            BooksContent(
                padding = it,
                books = uiState.books,
                navigateToBookScreen = navigateToBookScreen,
                deleteBook = { book ->
                    viewModel.deleteBook(book)
                }
            )
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

@Composable
fun BooksContent(
    padding: PaddingValues,
    books: List<Book>,
    deleteBook: (book: Book) -> Unit,
    navigateToBookScreen: (id: Int) -> Unit,
) {
    if (books.isEmpty()) {
        Text(text = "No books!")
        return
    }

    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(padding)
    ) {
        books.forEach { book ->
            BookCard(
                book = book,
                deleteBook = { deleteBook(book) },
                navigateToBookScreen = navigateToBookScreen,
            )
        }
    }
}

@OptIn(ExperimentalMaterialApi::class)
@Composable
fun BookCard(
    book: Book,
    deleteBook: () -> Unit,
    navigateToBookScreen: (id: Int) -> Unit,
) {
    Card(
        shape = RoundedCornerShape(4.dp),
        modifier = Modifier
            .padding(
                start = 8.dp,
                top = 4.dp,
                end = 8.dp,
                bottom = 4.dp
            )
            .fillMaxWidth(),
        elevation = 3.dp,
        onClick = { navigateToBookScreen(book.id) }
    ) {
        Row(
            modifier = Modifier
                .fillMaxWidth()
                .padding(12.dp),
            verticalAlignment = Alignment.CenterVertically
        )
        {
            Column {
                Text(text = book.title, style = MaterialTheme.typography.headlineSmall)
                Text(text = "by ${book.author}", style = MaterialTheme.typography.bodySmall)
                Text(text = "year: ${book.year}", fontSize = 12.sp)
                Text(text = "is lent: ${book.lent}", fontSize = 12.sp)
            }

            Spacer(modifier = Modifier.weight(1f))

            DeleteBookIcon(deleteBook = deleteBook)
        }
    }
}

@Composable
fun DeleteBookIcon(
    deleteBook: () -> Unit,
) {
    IconButton(onClick = deleteBook) {
        Icon(
            imageVector = Icons.Default.Delete,
            contentDescription = "Delete book"
        )
    }
}