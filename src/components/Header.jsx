import { Box, Flex } from '@chakra-ui/react'

const Header = (props) => {
    return (   
        <> 
        <Flex 
        bg='red'
        width='100%'
        height={['50px', '50px', '50px', '100px', '100px']}
        alignItems='center'
        justifyContent='center'
        boxShadow={'xl'}
        borderRadius={5}
        >   
        <Box
        color='white'
        fontSize={['lg', 'lg', 'lg', 'xl', 'xl']}
        fontWeight={'bold'}
        >
        {props.title}
        </Box>
        </Flex>        
        </>
    )
       
}

export default Header;